//
//  AddScheduleViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 9..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class AddScheduleViewController: UIViewController, CustomAlertShowing {
    
    // MARK: Properties
    
    @IBOutlet weak var opponentTextField: UITextField!
    @IBOutlet weak var matchPlaceTextField: UITextField!
    @IBOutlet weak var matchTimeLabel: UILabel!
    @IBOutlet weak var matchTimePicker: UIDatePicker!
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchTimePicker.minuteInterval = 10
        matchTimeLabel.text = dateFormatter.string(from: matchTimePicker.date)
        
        opponentTextField.delegate = self
        matchPlaceTextField.delegate = self
        
        matchTimePicker.setValue(UIColor.white, forKey: "textColor")
    }
    
    // MARK: Actions
    
    @IBAction private func matchTimePickerDidChanged(_ sender: UIDatePicker) {
        matchTimeLabel.text = dateFormatter.string(from: matchTimePicker.date)
    }
    
    @IBAction private func cancelButtonDidTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func doneButtonDidTapped(_ sender: UIBarButtonItem) {
        if opponentTextField.text == "" {
            showAlertOneButton(
                title: .alertActionTitle,
                message: .alertMessageOfEnterOpponentTeamName)
        }
        else if matchPlaceTextField.text == "" {
            showAlertOneButton(
                title: .alertActionTitle,
                message: .alertMessageOfEnterPlaceToMatch)
        }
        else {
            showAlertTwoButton(
                title: .alertTitleOfAddSchedule,
                message: .alertMessageOfAddSchedule,
                cancelActionTitle: .cancelActionTitle,
                confirmActionTitle: .confirmActionTitle,
                confirmAction: addSchedule)
        }
    }
    
    @objc fileprivate func addSchedule(action: UIAlertAction) {
        let teamSchedule = TeamSchedule(
            matchOpponent: opponentTextField.text!,
            matchDate: matchTimePicker.date,
            matchPlace: matchPlaceTextField.text!)
        
        TeamScheduleDAO.shared.insert(item: teamSchedule)
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Delegate

extension EditScheduleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return true
    }
}
