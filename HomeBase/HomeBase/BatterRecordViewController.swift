//
//  BatterRecordViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 13..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class BatterRecordViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private var singleHitButton: UIButton!
    @IBOutlet private var doubleHitButton: UIButton!
    @IBOutlet private var tripleHitButton: UIButton!
    @IBOutlet private var homeRunButton: UIButton!
    @IBOutlet private var baseOnBallsButton: UIButton!
    @IBOutlet private var sacrificeHitButton: UIButton!
    @IBOutlet private var strikeOutButton: UIButton!
    @IBOutlet private var groundBallButton: UIButton!
    @IBOutlet private var flyBallButton: UIButton!
    @IBOutlet private var stolenBaseButton: UIButton!
    @IBOutlet private var hitByPitchButton: UIButton!
    @IBOutlet private var runButton: UIButton!
    @IBOutlet private var RBIButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    private var singleHit: Double = 0.0
    private var doubleHit: Double = 0.0
    private var tripleHit: Double = 0.0
    private var homeRun: Double = 0.0
    private var baseOnBalls: Double = 0.0
    private var sacrificeHit: Double = 0.0
    private var strikeOut: Double = 0.0
    private var groundBall: Double = 0.0
    private var flyBall: Double = 0.0
    private var stolenBase: Double = 0.0
    private var hitByPitch: Double = 0.0
    private var run: Double = 0.0
    private var RBI: Double = 0.0
    
    private var batterButtons = [UIButton]()
    private var batterRecords = [Double]()
    private let batterRecordTexts = ["1루타", "2루타", "3루타",
                                     "홈런", "볼넷", "희생타",
                                     "삼진", "땅볼", "뜬공",
                                     "도루", "사구", "득점", "타점"]
    
    var row: Int!
    var playerID: Int64!
    var scheduleID: Int64!
    
    private var updatePlayerRecordID: Int64 = -1
    private var recordDidChange: Bool = false

    // MARK: Methods
    
    private func appendRecordButtons() {
        batterButtons.append(singleHitButton)
        batterButtons.append(doubleHitButton)
        batterButtons.append(tripleHitButton)
        batterButtons.append(homeRunButton)
        batterButtons.append(baseOnBallsButton)
        batterButtons.append(sacrificeHitButton)
        batterButtons.append(strikeOutButton)
        batterButtons.append(groundBallButton)
        batterButtons.append(flyBallButton)
        batterButtons.append(stolenBaseButton)
        batterButtons.append(hitByPitchButton)
        batterButtons.append(runButton)
        batterButtons.append(RBIButton)
        
        for index in 0..<batterButtons.count {
            batterButtons[index].tag = index
            batterButtons[index].addTarget(
                self,
                action: #selector(batterRecordButtonDidTapped(_:)),
                for: .touchUpInside)
        }
    }
    
    private func appendRecords() {
        batterRecords.append(singleHit)
        batterRecords.append(doubleHit)
        batterRecords.append(tripleHit)
        batterRecords.append(homeRun)
        batterRecords.append(baseOnBalls)
        batterRecords.append(sacrificeHit)
        batterRecords.append(strikeOut)
        batterRecords.append(groundBall)
        batterRecords.append(flyBall)
        batterRecords.append(stolenBase)
        batterRecords.append(hitByPitch)
        batterRecords.append(run)
        batterRecords.append(RBI)
    }
    
    private func fetchPlayerRecordOnSchedule() {
        if let existingRecord: PlayerRecord = PlayerRecordDAO.shared.selectPlayerRecordOnSchedule(
            playerID: self.playerID, scheduleID: self.scheduleID) {
            
            if existingRecord.playerID != 0 {
                recordDidChange = true
                
                self.updatePlayerRecordID = existingRecord.playerRecordID
                self.batterRecords[0] = existingRecord.singleHit
                self.batterRecords[1] = existingRecord.doubleHit
                self.batterRecords[2] = existingRecord.tripleHit
                self.batterRecords[3] = existingRecord.homeRun
                self.batterRecords[4] = existingRecord.baseOnBalls
                self.batterRecords[5] = existingRecord.sacrificeHit
                self.batterRecords[6] = existingRecord.strikeOut
                self.batterRecords[7] = existingRecord.groundBall
                self.batterRecords[8] = existingRecord.flyBall
                self.batterRecords[9] = existingRecord.stolenBase
                self.batterRecords[10] = existingRecord.hitByPitch
                self.batterRecords[11] = existingRecord.run
                self.batterRecords[12] = existingRecord.RBI
                
                for index in 0..<batterButtons.count {
                    
                    batterButtons[index].setTitle(
                        "\(batterRecordTexts[index])\n\(Int(batterRecords[index]))", for: .normal)
                    
                    batterButtons[index].titleLabel?.textAlignment = .center
                }
            }
        }
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
        
        appendRecordButtons()
        appendRecords()
        resetButton.addTarget(self, action: #selector(resetButtonDidTapped(_:)), for: .touchUpInside)
        
        fetchPlayerRecordOnSchedule()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == .unwindBatterToDetail {
            
            if recordDidChange == false {
                let playerRecord = PlayerRecord(
                    playerID: self.playerID,
                    scheduleID: self.scheduleID,
                    singleHit: self.batterRecords[0],
                    doubleHit: self.batterRecords[1],
                    tripleHit: self.batterRecords[2],
                    homeRun: self.batterRecords[3],
                    baseOnBalls: self.batterRecords[4],
                    sacrificeHit: self.batterRecords[5],
                    strikeOut: self.batterRecords[6],
                    groundBall: self.batterRecords[7],
                    flyBall: self.batterRecords[8],
                    stolenBase: self.batterRecords[9],
                    hitByPitch: self.batterRecords[10],
                    run: self.batterRecords[11],
                    RBI: self.batterRecords[12])
                
                PlayerRecordDAO.shared.insert(item: playerRecord)
            } else {
                let updatePlayerRecord = PlayerRecord(
                    playerRecordID: self.updatePlayerRecordID,
                    playerID: self.playerID,
                    scheduleID: self.scheduleID,
                    singleHit: self.batterRecords[0],
                    doubleHit: self.batterRecords[1],
                    tripleHit: self.batterRecords[2],
                    homeRun: self.batterRecords[3],
                    baseOnBalls: self.batterRecords[4],
                    sacrificeHit: self.batterRecords[5],
                    strikeOut: self.batterRecords[6],
                    groundBall: self.batterRecords[7],
                    flyBall: self.batterRecords[8],
                    stolenBase: self.batterRecords[9],
                    hitByPitch: self.batterRecords[10],
                    run: self.batterRecords[11],
                    RBI: self.batterRecords[12])
                
                PlayerRecordDAO.shared.update(item: updatePlayerRecord)
            }
        }
    }
    
    // MARK: Actions
    
    /// Tap action for Batter buttons.
    /// Increase button's record and show record on button title
    ///
    /// - Parameter sender: batter button
    @objc private func batterRecordButtonDidTapped(_ sender: UIButton) {
        self.batterRecords[sender.tag] += 1.0
        sender.setTitle("\(batterRecordTexts[sender.tag])\n\(Int(batterRecords[sender.tag]))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    
    @objc private func resetButtonDidTapped(_ sender: UIButton) {
        for index in 0..<batterRecords.count {
            self.batterRecords[index] = 0.0
            self.batterButtons[index].setTitle("\(batterRecordTexts[index])", for: .normal)
        }
    }
  
    @IBAction private func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
}
