//
//  SquadEditPlayerViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 17..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadEditPlayerViewController: UIViewController {
    
    // MARK: Properties
    
    var player: Player!
    
    @IBOutlet var playerNameTextField: UITextField!
    @IBOutlet var backNumberTextField: UITextField!
    @IBOutlet var positionPickerView: UIPickerView!
    
    var kindOfPosition: [String] = {
        var array = ["SP", "RP", "CP", "C", "1B", "2B", "3B", "SS", "LF", "CF", "RF", "DH"]
        
        return array
    }()
    
    var positionNumber: Int = 0
    
    // MAKR: Actions
    
    @IBAction func clickCancelButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func clickDoneButton(_ sender: UIBarButtonItem) {
        if let updatedName = playerNameTextField.text,
            let updatedBackNumberString = backNumberTextField.text {

            let updatedPosition = kindOfPosition[positionPickerView.selectedRow(inComponent: 0)]
            
            let updatePlayer = Player(
                id: player.playerID,
                name: updatedName,
                backNumber: Int64(updatedBackNumberString)!,
                position: updatedPosition)
            
            PlayerDAO.shared.update(playerObject: updatePlayer)

        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        playerNameTextField.text = player.name
        backNumberTextField.text = String(player.backNumber)
        
        positionPickerView.dataSource = self
        positionPickerView.delegate = self
        
        backNumberTextField.delegate = self
        for index in 0..<kindOfPosition.count {
            if player.position == "\(kindOfPosition[index])" {
                print(kindOfPosition[index])
                positionNumber = index
                break
            }
        }
        positionPickerView.showsSelectionIndicator = true
        positionPickerView.selectRow(positionNumber, inComponent: 0, animated: false)
        

        
    }
}

// MARK: PickerDelegate

extension SquadEditPlayerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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

extension SquadEditPlayerViewController: UITextFieldDelegate {
    
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
