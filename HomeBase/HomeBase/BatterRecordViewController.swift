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

    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
        
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
        
        for index in 0..<batterButtons.count {
            batterButtons[index].tag = index
            batterButtons[index].addTarget(
                self,
                action: #selector(batterRecordButtonDidTapped(_:)),
                for: .touchUpInside)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindBatterToDetail" {
            let playerRecord = PlayerRecord(playerID: self.playerID,
                                            scheduleID: self.scheduleID,
                                            singleHit: self.batterRecords[0],
                                            doubleHit: self.batterRecords[1],
                                            tripleHit: self.batterRecords[2],
                                            homeRun: self.batterRecords[3],
                                            baseOnBalls: self.batterRecords[4],
                                            strikeOut: self.batterRecords[5],
                                            groundBall: self.batterRecords[6],
                                            flyBall: self.batterRecords[7],
                                            sacrificeHit: self.batterRecords[8],
                                            stolenBase: self.batterRecords[9],
                                            run: self.batterRecords[10],
                                            RBI: self.batterRecords[11])
            
            PlayerRecordDAO.shared.insert(playerRecordObject: playerRecord)
        }
    }
    
    // MARK: Actions
    
    @objc private func batterRecordButtonDidTapped(_ sender: UIButton) {
        self.batterRecords[sender.tag] += 1.0
        sender.setTitle("\(batterRecordTexts[sender.tag])\n\(Int(batterRecords[sender.tag]))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
  
    @IBAction func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
}
