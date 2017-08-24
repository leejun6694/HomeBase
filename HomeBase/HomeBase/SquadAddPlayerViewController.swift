//
//  SquadAddPlayerViewController.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 8..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadAddPlayerViewController: UIViewController, CustomAlertShowing {
    
    var viewController: UIViewController {
        return self
    }
    
    // MARK: Properties
    
    @IBOutlet var playerNameTextField: UITextField!
    @IBOutlet var backNumberTextField: UITextField!
    @IBOutlet var positionPickerView: UIPickerView!
    @IBOutlet var doneButtonItem: UIBarButtonItem!
    
    var kindOfPosition: [String] = {
        var array = ["SP", "RP", "CP", "C", "1B", "2B", "3B", "SS", "LF", "CF", "RF", "DH"]
        
        return array
    }()
    
    // MARK: Actions
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        var overlapNumber: Bool = false
        
        if let numbers = PlayerDAO.shared.selectAllNumber() {
            for index in 0..<numbers.count {
                if backNumberTextField.text == "\(numbers[index])" {
                    overlapNumber = true
                    break
                }
            }

        }
        
        if playerNameTextField.text == "" {
            showAlertOneButton(
                title: .alertActionTitle,
                message: .alertMessageOfEnterPlayerName)
        } else if backNumberTextField.text == "" {
            showAlertOneButton(
                title: .alertActionTitle,
                message: .alertMessageOfEnterPlayerBackNumber)
        } else if overlapNumber == true {
            showAlertOneButton(
                title: .alertActionTitle,
                message: .alertMessageOfDuplicatePlayerBackNumber)
        } else {
            showAlertTwoButton(
                title: .alertTitleOfAddPlayer,
                message: .alertMessageOfAddPlayer,
                cancelActionTitle: .cancelActionTitle,
                confirmActionTitle: .confirmActionTitle,
                confirmAction: addPlayer)
        }
    }
    
    fileprivate func addPlayer(action: UIAlertAction) {
        let name = playerNameTextField.text!
        let backNumber = Int(backNumberTextField.text!)!
        
        let position = kindOfPosition[positionPickerView.selectedRow(inComponent: 0)]
        let player = Player(name: name, backNumber: backNumber, position: position)
        PlayerDAO.shared.insert(item: player)
        
        dismiss(animated: true, completion: nil)
    }

    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionPickerView.dataSource = self
        positionPickerView.delegate = self
        
        backNumberTextField.delegate = self
    }
}

// MARK: PickerDelegate

extension SquadAddPlayerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kindOfPosition.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kindOfPosition[row]
    }
}

// MARK: TextFieldDelegate

extension SquadAddPlayerViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCount = textField.text?.characters.count ?? 0
        let replacementCount = currentCount + string.characters.count - range.length
        
        if replacementCount <= 2 {
            return true
        } else {
            showAlertOneButton(
                title: .alertActionTitle,
                message: .alertMessageOfMaxPlayerBackNumber)
    
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
}
