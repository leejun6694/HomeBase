//
//  PitcherRecordViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 13..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class PitcherRecordViewController: UIViewController {
   
    // MARK: Properties
    
    @IBOutlet fileprivate var pitcherView: UIView!
    @IBOutlet private var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet private var pitcherStackView: UIStackView!
    
    @IBOutlet private var winButton: UIButton!
    @IBOutlet private var loseButton: UIButton!
    @IBOutlet private var holdButton: UIButton!
    @IBOutlet private var saveButton: UIButton!
    @IBOutlet private var walksButton: UIButton!
    @IBOutlet private var hitBattersButton: UIButton!
    @IBOutlet private var hitsButton: UIButton!
    @IBOutlet private var homeRunsButton: UIButton!
    @IBOutlet private var inningButton: UIButton!
    @IBOutlet private var strikeOutsButton: UIButton!
    @IBOutlet private var ERButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    private var win: Double = 0.0
    private var lose: Double = 0.0
    private var hold: Double = 0.0
    private var save: Double = 0.0
    private var walks: Double = 0.0
    private var hitBatters: Double = 0.0
    private var hits: Double = 0.0
    private var homeRuns: Double = 0.0
    private var inning: Double = 0.0
    private var strikeOuts: Double = 0.0
    private var ER: Double = 0.0
    
    private var inningRemainder: Double = 0.0
    
    private var pitcherButtons = [UIButton]()
    private var pitcherRecords = [Double]()
    private var pitcherRecordTexts = ["승리", "패배", "홀드", "세이브",
                                      "볼넷", "사구", "피안타", "피홈런",
                                      "이닝", "탈삼진", "자책점"]
    private var tapGestures = [UITapGestureRecognizer]()
    private var longPressGestures = [UILongPressGestureRecognizer]()
    
    var row: Int!
    var playerID: Int64!
    var scheduleID: Int64!
    
    private var updatePlayerRecordID: Int64 = -1
    private var recordDidChange: Bool = false
    
    private lazy var winTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var loseTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var holdTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var saveTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var walksTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var hitBattersTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var hitsTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var homeRunsTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var inningTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var strikeOutsTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var ERTap: UITapGestureRecognizer = {
        [unowned self] in
        return UITapGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonDidTapped(_:)))
    }()
    
    private lazy var walksLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonLongPressed(_:)))
    }()
    
    private lazy var hitBattersLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonLongPressed(_:)))
    }()
    
    private lazy var hitsLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonLongPressed(_:)))
    }()
    
    private lazy var homeRunsLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonLongPressed(_:)))
    }()
    
    private lazy var inningLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonLongPressed(_:)))
    }()
    
    private lazy var strikeOutsLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonLongPressed(_:)))
    }()
    
    private lazy var ERLongPress: UILongPressGestureRecognizer = {
        [unowned self] in
        return UILongPressGestureRecognizer(
            target: self,
            action: #selector(self.pitcherRecordButtonLongPressed(_:)))
    }()
    
    // MARK: Methods
    
    private func appendRecordButtons() {
        pitcherButtons.append(winButton)
        pitcherButtons.append(loseButton)
        pitcherButtons.append(holdButton)
        pitcherButtons.append(saveButton)
        pitcherButtons.append(walksButton)
        pitcherButtons.append(hitBattersButton)
        pitcherButtons.append(hitsButton)
        pitcherButtons.append(homeRunsButton)
        pitcherButtons.append(inningButton)
        pitcherButtons.append(strikeOutsButton)
        pitcherButtons.append(ERButton)
        
        for index in 0..<pitcherButtons.count {
            pitcherButtons[index].tag = index
            pitcherButtons[index].addTarget(
                self,
                action: #selector(pitcherRecordButtonDidTapped(_:)),
                for: .touchUpInside)
            pitcherButtons[index].titleLabel?.textAlignment = .center
        }
    }
    
    private func appendGestureRecognizers() {
        tapGestures.append(winTap)
        tapGestures.append(loseTap)
        tapGestures.append(holdTap)
        tapGestures.append(saveTap)
        tapGestures.append(walksTap)
        tapGestures.append(hitBattersTap)
        tapGestures.append(hitsTap)
        tapGestures.append(homeRunsTap)
        tapGestures.append(inningTap)
        tapGestures.append(strikeOutsTap)
        tapGestures.append(ERTap)
        
        longPressGestures.append(walksLongPress)
        longPressGestures.append(hitBattersLongPress)
        longPressGestures.append(hitsLongPress)
        longPressGestures.append(homeRunsLongPress)
        longPressGestures.append(inningLongPress)
        longPressGestures.append(strikeOutsLongPress)
        longPressGestures.append(ERLongPress)
        
        for index in 0..<pitcherButtons.count {
            pitcherButtons[index].addGestureRecognizer(tapGestures[index])
            
            if index > 3 {
                pitcherButtons[index].addGestureRecognizer(longPressGestures[index - 4])
            }
        }
    }
    
    private func appendRecords() {
        pitcherRecords.append(win)
        pitcherRecords.append(lose)
        pitcherRecords.append(hold)
        pitcherRecords.append(save)
        pitcherRecords.append(walks)
        pitcherRecords.append(hitBatters)
        pitcherRecords.append(hits)
        pitcherRecords.append(homeRuns)
        pitcherRecords.append(inning)
        pitcherRecords.append(strikeOuts)
        pitcherRecords.append(ER)
    }
    
    private func fetchPlayerRecordOnSchedule() {
        if let existingRecord: PlayerRecord = PlayerRecordDAO.shared.selectPlayerRecordOnSchedule(
            playerID: self.playerID, scheduleID: self.scheduleID) {
            
            if existingRecord.playerID != 0 {
                recordDidChange = true
                
                self.updatePlayerRecordID = existingRecord.playerRecordID
                self.pitcherRecords[0] = existingRecord.win
                self.pitcherRecords[1] = existingRecord.lose
                self.pitcherRecords[2] = existingRecord.hold
                self.pitcherRecords[3] = existingRecord.save
                self.pitcherRecords[4] = existingRecord.walks
                self.pitcherRecords[5] = existingRecord.hitBatters
                self.pitcherRecords[6] = existingRecord.hits
                self.pitcherRecords[7] = existingRecord.homeRuns
                self.pitcherRecords[8] = existingRecord.inning
                self.pitcherRecords[9] = existingRecord.strikeOuts
                self.pitcherRecords[10] = existingRecord.ER
                
                for index in 0..<pitcherButtons.count {
                    
                    if index == 8 {
                        let updateInningRemainder = (Int(pitcherRecords[index] * 10) % 10) / 3
                        let updateInning = Int(pitcherRecords[index])
                        
                        self.inningRemainder = Double(updateInningRemainder)
                        self.pitcherRecords[index] = Double(updateInning)
                        
                        if updateInningRemainder == 0, updateInning == 0 {
                            pitcherButtons[index].setTitle("\(pitcherRecordTexts[index])", for: .normal)
                        } else if updateInningRemainder == 0 {
                            pitcherButtons[index].setTitle(
                                "\(pitcherRecordTexts[index])\n\(updateInning)",
                                for: .normal)
                        } else {
                            pitcherButtons[index].setTitle(
                                "\(pitcherRecordTexts[index])\n\(updateInning) \(updateInningRemainder)/3",
                                for: .normal)
                        }
                        
                    } else {
                        if pitcherRecords[index] == 0.0 {
                            pitcherButtons[index].setTitle(
                                "\(pitcherRecordTexts[index])", for: .normal)
                        } else {
                            pitcherButtons[index].setTitle(
                                "\(pitcherRecordTexts[index])\n\(Int(pitcherRecords[index]))",
                                for: .normal)
                        }
                    }
                    
                    if index < 4, pitcherRecords[index] > 0.0 {
                        pitcherStackView.alpha = 0.5
                        pitcherStackView.isUserInteractionEnabled = false
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
        
        tapGestureRecognizer.delegate = self
        
        appendRecordButtons()
        appendGestureRecognizers()
        appendRecords()
        resetButton.addTarget(self, action: #selector(resetButtonDidTapped(_:)), for: .touchUpInside)
        
        fetchPlayerRecordOnSchedule()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == .unwindPitcherToDetail {
            
            self.pitcherRecords[8] += self.inningRemainder / 3.0
            
            if recordDidChange == false {
                let playerRecord = PlayerRecord(
                    playerID: self.playerID,
                    scheduleID: self.scheduleID,
                    win: self.pitcherRecords[0],
                    lose: self.pitcherRecords[1],
                    hold: self.pitcherRecords[2],
                    save: self.pitcherRecords[3],
                    walks: self.pitcherRecords[4],
                    hitBatters: self.pitcherRecords[5],
                    hits: self.pitcherRecords[6],
                    homeRuns: self.pitcherRecords[7],
                    inning: self.pitcherRecords[8],
                    strikeOuts: self.pitcherRecords[9],
                    ER: self.pitcherRecords[10])
                
                PlayerRecordDAO.shared.insert(item: playerRecord)
            } else {
                let updatePlayerRecord = PlayerRecord(
                    playerRecordID: self.updatePlayerRecordID,
                    playerID: self.playerID,
                    scheduleID: self.scheduleID,
                    win: self.pitcherRecords[0],
                    lose: self.pitcherRecords[1],
                    hold: self.pitcherRecords[2],
                    save: self.pitcherRecords[3],
                    walks: self.pitcherRecords[4],
                    hitBatters: self.pitcherRecords[5],
                    hits: self.pitcherRecords[6],
                    homeRuns: self.pitcherRecords[7],
                    inning: self.pitcherRecords[8],
                    strikeOuts: self.pitcherRecords[9],
                    ER: self.pitcherRecords[10])
                
                PlayerRecordDAO.shared.update(item: updatePlayerRecord)
            }
        }
    }
    
    // MARK: Actions

    /// Tap action for Pitcher buttons.
    /// Increase button's record and show record on button title
    ///
    /// - Parameter sender: pitcher button's UITapGestureRecognizer
    @objc private func pitcherRecordButtonDidTapped(_ sender: UITapGestureRecognizer) {
        let button = sender.view as! UIButton
        
        if button.tag == 8 {
            self.inningRemainder += 1.0
            if inningRemainder == 3.0 {
                self.pitcherRecords[button.tag] += 1.0
                self.inningRemainder = 0.0
            }
            
            if self.inningRemainder == 0.0 {
                button.setTitle(
                    "\(pitcherRecordTexts[button.tag])\n\(Int(pitcherRecords[button.tag]))",
                    for: .normal)
            } else {
                button.setTitle(
                    "\(pitcherRecordTexts[button.tag])\n\(Int(pitcherRecords[button.tag])) \(Int(inningRemainder))/3",
                    for: .normal)
            }
        } else {
            self.pitcherRecords[button.tag] += 1.0
            button.setTitle(
                "\(pitcherRecordTexts[button.tag])\n\(Int(pitcherRecords[button.tag]))",
                for: .normal)
        }
        
        if button.tag < 4 {
            pitcherStackView.alpha = 0.5
            pitcherStackView.isUserInteractionEnabled = false
        }
    }
    
    /// Long Press action for Pitcher buttons.
    /// Decrease button's record and show record on button title
    ///
    /// - Parameter sender: pitcher button's UILongPressGestureRecognizer
    @objc private func pitcherRecordButtonLongPressed(_ sender: UILongPressGestureRecognizer) {
        let button = sender.view as! UIButton
        
        if button.tag == 8, sender.state == .ended {
            if self.inningRemainder != 0.0 || self.pitcherRecords[button.tag] != 0.0 {
                if self.inningRemainder == 0.0 {
                    self.pitcherRecords[button.tag] -= 1.0
                    self.inningRemainder = 2.0
                } else {
                    self.inningRemainder -= 1.0
                }
            }
            
            if self.inningRemainder == 0.0, self.pitcherRecords[button.tag] == 0.0 {
                button.setTitle("\(pitcherRecordTexts[button.tag])", for: .normal)
            } else if self.inningRemainder == 0.0 {
                button.setTitle(
                    "\(pitcherRecordTexts[button.tag])\n\(Int(pitcherRecords[button.tag]))",
                    for: .normal)
            } else {
                button.setTitle(
                    "\(pitcherRecordTexts[button.tag])\n\(Int(pitcherRecords[button.tag])) \(Int(inningRemainder))/3",
                    for: .normal)
            }
        } else if sender.state == .ended {
            if self.pitcherRecords[button.tag] > 0.0 {
                self.pitcherRecords[button.tag] -= 1.0
                
                if self.pitcherRecords[button.tag] == 0.0 {
                    button.setTitle("\(pitcherRecordTexts[button.tag])", for: .normal)
                } else {
                    button.setTitle(
                        "\(pitcherRecordTexts[button.tag])\n\(Int(pitcherRecords[button.tag]))",
                        for: .normal)
                }
            }
        }
    }
    
    @objc private func resetButtonDidTapped(_ sender: UIButton) {
        for index in 0..<pitcherRecords.count {
            self.pitcherRecords[index] = 0.0
            self.pitcherButtons[index].setTitle("\(pitcherRecordTexts[index])", for: .normal)
        }
        
        self.inningRemainder = 0.0
        
        pitcherStackView.alpha = 1.0
        pitcherStackView.isUserInteractionEnabled = true
    }
  
    @IBAction private func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
}

extension PitcherRecordViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: pitcherView) {
            return false
        }
        
        return true
    }
}
