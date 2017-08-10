//
//  SquadAddPlayerViewController.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 8..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadAddPlayerViewController: UIViewController {
    
    @IBOutlet var playerNameTextField: UITextField!
    @IBOutlet var backNumberTextField: UITextField!
    @IBOutlet var positionPickerView: UIPickerView!
    @IBOutlet var doneButtonItem: UIBarButtonItem!
    let playerDAO = PlayerDAO()
    
    var kindOfPosition: [String] = {
        var array = ["SP", "RP", "CP", "C", "1B", "2B", "3B", "SS", "LF", "CF", "RF", "DH"]
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerDAO.createTable()
        positionPickerView.dataSource = self
        positionPickerView.delegate = self
        
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        guard let name = playerNameTextField.text,
            let backNumberString = backNumberTextField.text,
            let backNumber = Int64(backNumberString) else {
                return
        }
        print(backNumber)
        let position = kindOfPosition[positionPickerView.selectedRow(inComponent: 0)]
        PlayerDAO.shared.insert(_name: name, _backNumber: backNumber, _position: position)
        dismiss(animated: true, completion: nil)
    }

    
}

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
