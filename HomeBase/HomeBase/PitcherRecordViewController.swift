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
    
    var row: Int!
    var playerID: Int64!
    var scheduleID: Int64!
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
        
        tapGestureRecognizer.delegate = self
        
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
        
        for index in 0..<pitcherButtons.count {
            pitcherButtons[index].tag = index
            pitcherButtons[index].addTarget(
                self,
                action: #selector(pitcherRecordButtonDidTapped(_:)),
                for: .touchUpInside)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindPitcherToDetail" {
            
            self.pitcherRecords[8] += self.inningRemainder / 3.0
            
            let playerRecord = PlayerRecord(playerID: self.playerID,
                                            scheduleID: self.scheduleID,
                                            win: self.pitcherRecords[0],
                                            lose: self.pitcherRecords[1],
                                            save: self.pitcherRecords[3],
                                            hold: self.pitcherRecords[2],
                                            inning: self.pitcherRecords[8],
                                            hits: self.pitcherRecords[6],
                                            homeRuns: self.pitcherRecords[7],
                                            walks: self.pitcherRecords[4],
                                            hitBatters: self.pitcherRecords[5],
                                            strikeOuts: self.pitcherRecords[9],
                                            ER: self.pitcherRecords[10])
            
            PlayerRecordDAO.shared.insert(playerRecordObject: playerRecord)
        }
    }
    
    // MARK: Actions

    /// Tap action for Pitcher buttons.
    /// Increase button's record and show record on button title
    ///
    /// - Parameter sender: pitcher button
    @objc private func pitcherRecordButtonDidTapped(_ sender: UIButton) {
        if sender.tag == 8 {
            self.inningRemainder += 1.0
            if inningRemainder == 3.0 {
                self.pitcherRecords[sender.tag] += 1.0
                self.inningRemainder = 0.0
            }
            
            if self.inningRemainder == 0.0 {
                sender.setTitle(
                    "\(pitcherRecordTexts[sender.tag])\n\(Int(pitcherRecords[sender.tag]))", for: .normal)
            } else {
                sender.setTitle(
                    "\(pitcherRecordTexts[sender.tag])\n\(Int(pitcherRecords[sender.tag])) \(Int(inningRemainder))/3",
                    for: .normal)
            }
        } else {
            self.pitcherRecords[sender.tag] += 1.0
            sender.setTitle(
                "\(pitcherRecordTexts[sender.tag])\n\(Int(pitcherRecords[sender.tag]))",
                for: .normal)
        }
        
        if sender.tag < 4 {
            pitcherStackView.alpha = 0.5
            pitcherStackView.isUserInteractionEnabled = false
        }
      
        sender.titleLabel?.textAlignment = .center
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
