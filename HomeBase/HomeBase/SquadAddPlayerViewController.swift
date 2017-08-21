//
//  SquadAddPlayerViewController.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 8..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadAddPlayerViewController: UIViewController {
    
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
        var alertController: UIAlertController
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
            alertController = UIAlertController(title: "경고",
                                                message: "선수 이름을 입력하세요",
                                                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        else if backNumberTextField.text == "" {
            alertController = UIAlertController(title: "경고",
                                                message: "선수 번호를 입력하세요",
                                                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        else if overlapNumber == true {
            alertController = UIAlertController(title: "경고",
                                                message: "중복되는 선수 번호입니다",
                                                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        else {
            alertController = UIAlertController(title: "선수 추가",
                                                message: "선수를 추가하시겠습니까?",
                                                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler: addPlayer)
            let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc fileprivate func addPlayer(action: UIAlertAction) {
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
        }
        else {
            let alertController = UIAlertController(title: "", message: "선수 번호는 최대 99 입니다",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
            
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
}
