//
//  AddScheduleViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 9..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class AddScheduleViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var opponentTextField: UITextField!
    @IBOutlet weak var matchPlaceTextField: UITextField!
    @IBOutlet weak var matchTimeLabel: UILabel!
    @IBOutlet weak var matchTimePicker: UIDatePicker!
    
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
    
    @IBAction func clickCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickDoneButton(_ sender: UIBarButtonItem) {
        let alertController: UIAlertController
        
        if opponentTextField.text == "" {
            alertController = UIAlertController(title: "경고", message: "상대 팀명을 입력하세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        else if matchPlaceTextField.text == "" {
            alertController = UIAlertController(title: "경고", message: "경기 장소를 입력하세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okAction)
        }
        else {
            alertController = UIAlertController(title: "일정 추가", message: "경기를 추가하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: addSchedule)
            let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc fileprivate func addSchedule(action: UIAlertAction) {
        let teamSchedule = TeamSchedule(matchOpponent: opponentTextField.text!, matchDate: matchTimePicker.date, matchPlace: matchPlaceTextField.text!)
        
        TeamScheduleDAO.shared.insert(insertTeamSchedule: teamSchedule)
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchTimePicker.minuteInterval = 10
        matchTimeLabel.text = dateFormatter.string(from: matchTimePicker.date)
    }
}
