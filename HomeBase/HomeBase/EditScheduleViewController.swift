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
        let id = preSchedule.scheduleID
        let opponent = opponentTextField.text!
        let date = matchTimePicker.date
        print(dateFormatter.string(from: date))
        let updatedteamSchedule = TeamSchedule(
            scheduleID: id,
            matchOpponent: opponent,
            matchDate: date,
            matchPlace: matchPlaceTextField.text!)
        TeamScheduleDAO.shared.update(item: updatedteamSchedule)
        let currentDate = Date()
        let compareDate = date.timeIntervalSince(currentDate)
        let compareHour = compareDate / 3600
        let compareDay = compareDate / (3600 * 24)
        print("Compare Hour \(compareHour)")
        var hour = false
        var day = false
        if compareHour >= 1 {
            hour = true
            print("Edit HOUR")
            if compareDay >= 1 {
                day = true
                print("Edit DAY")
            }
        }
        MyNotification.update(
            contentOfBody: opponent,
            appliedDate: date,
            day: day,
            hour: hour,
            identifierID: id)

        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opponentTextField.text = preSchedule.matchOpponent
        matchPlaceTextField.text = preSchedule.matchPlace
        
        matchTimePicker.minuteInterval = 1
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
