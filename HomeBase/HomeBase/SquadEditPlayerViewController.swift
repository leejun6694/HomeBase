//
//  SquadEditPlayerViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 17..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadEditPlayerViewController: UIViewController, CustomAlertShowing {
    
    var viewController: UIViewController {
        return self
    }
    
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
        var overlapNumber: Bool = false
        
        let numbers = PlayerDAO.shared.selectAllNumber()
        for index in 0..<numbers.count {
            if backNumberTextField.text == "\(numbers[index])" {
                overlapNumber = true
                break
            }
        }
        
        if playerNameTextField.text == "" {
            showAlertOneButton(title: "경고", message: "선수 이름을 입력하세요")
        } else if backNumberTextField.text == "" {
            showAlertOneButton(title: "경고", message: "선수 번호를 입력하세요")
        } else if overlapNumber == true {
            showAlertOneButton(title: "경고", message: "팀에 중복되는 번호가 있습니다")
        } else {
            showAlertTwoButton(title: "선수 수정", message: "선수 정보를 수정하시겠습니까?", confirmAction: editPlayer)
        }
    }
    
    fileprivate func editPlayer(action: UIAlertAction) {
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
            showAlertOneButton(title: "경고", message: "선수 번호는 최대 99 입니다")
            
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
}
