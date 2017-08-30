//
//  BatterRecordViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 13..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class BatterRecordViewController: UIViewController, CustomAlertShowing {
    
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
    private let batterRecordTexts: [String] = [.single, .double, .triple,
                                     .homerun, .baseOnBalls, .sacrificeHit,
                                     .strikeOut, .groundBall, .flyBall,
                                     .stolenBase, .hitByPitch, .run, .rbi]
    private var tapGestures = [UITapGestureRecognizer]()
    private var longPressGestures = [UILongPressGestureRecognizer]()
    
    var row: Int!
    var playerID: Int64!
    var scheduleID: Int64!
    
    private var updatePlayerRecordID: Int64 = -1
    private var recordDidChange: Bool = false

    private lazy var singleHitTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var doubleHitTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var tripleHitTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var homeRunTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var baseOnBallTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var sacrificeHitTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var strikeOutTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var groundBallTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var flyBallTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var stolenBaseTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var hitByPitchTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var runTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var RBITap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonDidTapped(_:)))
    }()
    
    private lazy var singleHitLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var doubleHitLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var tripleHitLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var homeRunLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var baseOnBallLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var sacrificeHitLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var strikeOutLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var groundBallLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var flyBallLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var stolenBaseLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var hitByPitchLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var runLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
    private lazy var RBILongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.batterRecordButtonLongPressed(_:)))
    }()
    
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
            batterButtons[index].titleLabel?.textAlignment = .center
        }
    }
    
    private func appendGestureRecognizers() {
        tapGestures.append(singleHitTap)
        tapGestures.append(doubleHitTap)
        tapGestures.append(tripleHitTap)
        tapGestures.append(homeRunTap)
        tapGestures.append(baseOnBallTap)
        tapGestures.append(sacrificeHitTap)
        tapGestures.append(strikeOutTap)
        tapGestures.append(groundBallTap)
        tapGestures.append(flyBallTap)
        tapGestures.append(stolenBaseTap)
        tapGestures.append(hitByPitchTap)
        tapGestures.append(runTap)
        tapGestures.append(RBITap)
        
        longPressGestures.append(singleHitLongPress)
        longPressGestures.append(doubleHitLongPress)
        longPressGestures.append(tripleHitLongPress)
        longPressGestures.append(homeRunLongPress)
        longPressGestures.append(baseOnBallLongPress)
        longPressGestures.append(sacrificeHitLongPress)
        longPressGestures.append(strikeOutLongPress)
        longPressGestures.append(groundBallLongPress)
        longPressGestures.append(flyBallLongPress)
        longPressGestures.append(stolenBaseLongPress)
        longPressGestures.append(hitByPitchLongPress)
        longPressGestures.append(runLongPress)
        longPressGestures.append(RBILongPress)
        
        for index in 0..<batterButtons.count {
            batterButtons[index].addGestureRecognizer(tapGestures[index])
            batterButtons[index].addGestureRecognizer(longPressGestures[index])
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
                    if batterRecords[index] == 0.0 {
                        batterButtons[index].setTitle(
                            "\(batterRecordTexts[index])", for: .normal)
                    } else {
                        batterButtons[index].setTitle(
                            "\(batterRecordTexts[index])\n\(Int(batterRecords[index]))", for: .normal)
                    }
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
        appendGestureRecognizers()
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
                
                do {
                    try PlayerRecordDAO.shared.insert(item: playerRecord)
                } catch let error {
                    showAlertOneButton(
                        title: .alertActionTitle,
                        message: error.localizedDescription)
                }
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
                
                do {
                    try PlayerRecordDAO.shared.update(item: updatePlayerRecord)
                } catch let error {
                    showAlertOneButton(
                        title: .alertActionTitle,
                        message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: Actions
    
    /// Tap action for Batter buttons.
    /// Increase button's record and show record on button title.
    ///
    /// - Parameter sender: batter button's UITapGestureRecognizer
    @objc private func batterRecordButtonDidTapped(_ sender: UITapGestureRecognizer) {
        let button = sender.view as! UIButton
        
        self.batterRecords[button.tag] += 1.0
        button.setTitle(
            "\(batterRecordTexts[button.tag])\n\(Int(batterRecords[button.tag]))",
            for: .normal)
    }
    
    /// Long Press action for Batter Buttons.
    /// Decrease button's record and show record on button title.
    ///
    /// - Parameter sender: batter button's UILongPressGestureRecognizer
    @objc private func batterRecordButtonLongPressed(_ sender: UILongPressGestureRecognizer) {
        let button = sender.view as! UIButton
        
        if sender.state == .ended, self.batterRecords[button.tag] > 0.0 {
            self.batterRecords[button.tag] -= 1.0
            
            if self.batterRecords[button.tag] == 0.0 {
                button.setTitle("\(batterRecordTexts[button.tag])", for: .normal)
            } else {
                button.setTitle(
                    "\(batterRecordTexts[button.tag])\n\(Int(batterRecords[button.tag]))",
                    for: .normal)
            }
        }
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
