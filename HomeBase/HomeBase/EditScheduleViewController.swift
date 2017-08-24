//
//  EditScheduleViewController.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 21..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class EditScheduleViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var opponentTextField: UITextField!
    @IBOutlet weak var matchPlaceTextField: UITextField!
    @IBOutlet weak var matchTimeLabel: UILabel!
    @IBOutlet weak var matchTimePicker: UIDatePicker!
    
    var preSchedule: TeamSchedule!
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    // MARK: Actions
    
    @IBAction func changeMatchTimePicker(_ sender: UIDatePicker) {
        matchTimeLabel.text = dateFormatter.string(from: matchTimePicker.date)
    }
    
    @IBAction func cancelButtonDidTab(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        let alertController: UIAlertController
        
        if opponentTextField.text == "" {
            alertController = UIAlertController(
                title: .alertActionTitle,
                message: .alertMessageOfEnterOpponentTeamName,
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(
                title: .confirmActionTitle,
                style: .default,
                handler: nil)
            alertController.addAction(okAction)
        }
        else if matchPlaceTextField.text == "" {
            alertController = UIAlertController(
                title: .alertActionTitle,
                message: .alertMessageOfEnterPlaceToMatch,
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(
                title: .confirmActionTitle,
                style: .default,
                handler: nil)
            alertController.addAction(okAction)
        }
        else {
            alertController = UIAlertController(
                title: .alertMessageOfEditMatchSchedule,
                message: .alertMessageOfEditMatchSchedule,
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(
                title: .confirmActionTitle,
                style: .default,
                handler: editSchedule)
            let cancelAction = UIAlertAction(
                title: .cancelActionTitle,
                style: .destructive,
                handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc fileprivate func editSchedule(action: UIAlertAction) {
        let updatedteamSchedule = TeamSchedule(
            scheduleID: preSchedule.scheduleID,
            matchOpponent: opponentTextField.text!,
            matchDate: matchTimePicker.date,
            matchPlace: matchPlaceTextField.text!)
        TeamScheduleDAO.shared.update(item: updatedteamSchedule)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opponentTextField.text = preSchedule.matchOpponent
        matchPlaceTextField.text = preSchedule.matchPlace
        
        matchTimePicker.minuteInterval = 10
        matchTimePicker.setDate(preSchedule.matchDate, animated: true)
        matchTimePicker.setValue(UIColor.white, forKey: "textColor")
        
        matchTimeLabel.text = dateFormatter.string(from: matchTimePicker.date)
        
        opponentTextField.delegate = self
        matchPlaceTextField.delegate = self
    }

}

// MARK: Delegate

extension AddScheduleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return true
    }
}
