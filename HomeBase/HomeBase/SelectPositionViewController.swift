//
//  SelectPositionViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 13..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SelectPositionViewController: UIViewController, CustomAlertShowing {
    
    // MARK: Properties
    
    @IBOutlet var batterButton: UIButton!
    @IBOutlet var pitcherButton: UIButton!
    
    var row: Int!
    var playerID: Int64!
    var scheduleID: Int64!
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
        
        if let existingRecord = PlayerRecordDAO.shared.selectPlayerRecordOnSchedule(
            playerID: self.playerID, scheduleID: self.scheduleID) {
            
            let sumOfPlayerRecord = PlayerRecordDAO.shared.selectSumOfPlayerRecord(
                playerRecordID: existingRecord.playerRecordID)
            let sumOfBatterRecord = PlayerRecordDAO.shared.selectSumOfBatterRecord(
                playerRecordID: existingRecord.playerRecordID)
            
            if existingRecord.playerID == 0 || sumOfPlayerRecord == 0 {
                batterButton.addTarget(self, action: #selector(batterButtonDidTapped(_:)), for: .touchUpInside)
                pitcherButton.addTarget(self, action: #selector(pitcherButtonDidTapped(_:)), for: .touchUpInside)
            } else if sumOfBatterRecord == 0 {
                batterButton.addTarget(self, action: #selector(batterButtonDisabled(_:)), for: .touchUpInside)
                pitcherButton.addTarget(self, action: #selector(pitcherButtonDidTapped(_:)), for: .touchUpInside)
            } else {
                batterButton.addTarget(self, action: #selector(batterButtonDidTapped(_:)), for: .touchUpInside)
                pitcherButton.addTarget(self, action: #selector(pitcherButtonDisabled(_:)), for: .touchUpInside)
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction private func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc private func batterButtonDisabled(_ sender: UIButton) {
        showAlertOneButton(
            title: .alertActionTitle,
            message: .alertMessageOfInitializePitcherRecord)
    }
    
    @objc private func pitcherButtonDisabled(_ sender: UIButton) {
        showAlertOneButton(
            title: .alertActionTitle,
            message: .alertMessageOfInitializeBatterRecord)
    }
    
    @objc private func batterButtonDidTapped(_ sender: UIButton) {
        let batterRecordViewController = self.storyboard!.instantiateViewController(
            withIdentifier: .batterRecordViewController) as! BatterRecordViewController
        
        batterRecordViewController.row = self.row
        batterRecordViewController.playerID = self.playerID
        batterRecordViewController.scheduleID = self.scheduleID
        
        batterRecordViewController.modalPresentationStyle = .currentContext
        
        present(batterRecordViewController, animated: false, completion: nil)
    }
    
    @objc private func pitcherButtonDidTapped(_ sender: UIButton) {
        let pitcherRecordViewController = self.storyboard!.instantiateViewController(
            withIdentifier: .pitcherRecordViewController) as! PitcherRecordViewController
        
        pitcherRecordViewController.row = self.row
        pitcherRecordViewController.playerID = self.playerID
        pitcherRecordViewController.scheduleID = self.scheduleID
        
        pitcherRecordViewController.modalPresentationStyle = .currentContext
        
        present(pitcherRecordViewController, animated: false, completion: nil)
    }
}
