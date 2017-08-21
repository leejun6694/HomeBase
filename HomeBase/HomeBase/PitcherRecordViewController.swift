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
    
    var row: Int!
    var playerID: Int64!
    var scheduleID: Int64!
    
    var win: Double = 0.0
    var lose: Double = 0.0
    var hold: Double = 0.0
    var save: Double = 0.0
    var inning: Double = 0.0
    var inningRemainder: Double = 0.0
    var hits: Double = 0.0
    var homeRuns: Double = 0.0
    var walks: Double = 0.0
    var hitBatters: Double = 0.0
    var strikeOuts: Double = 0.0
    var ER: Double = 0.0
    
    @IBOutlet var pitcherView: UIView!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var pitcherStackView: UIStackView!
    
    // MARK: Actions
    
    @IBAction func clickBackgroundView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
        
        tapGestureRecognizer.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindPitcherToDetail" {
            
            self.inning += self.inningRemainder / 3.0
            
            let playerRecord = PlayerRecord(playerID: self.playerID,
                                            scheduleID: self.scheduleID,
                                            win: self.win,
                                            lose: self.lose,
                                            save: self.save,
                                            hold: self.hold,
                                            inning: self.inning,
                                            hits: self.hits,
                                            homeRuns: self.homeRuns,
                                            walks: self.walks,
                                            hitBatters: self.hitBatters,
                                            strikeOuts: self.strikeOuts,
                                            ER: self.ER)
            
            PlayerRecordDAO.shared.insert(item: playerRecord)
        }
    }
    
    
    // MARK: Record Buttons
    
    @IBAction func clickWin(_ sender: UIButton) {
        self.win += 1.0
        sender.setTitle("승리\n\(Int(win))", for: .normal)
        sender.titleLabel?.textAlignment = .center
        
        pitcherStackView.alpha = 0.5
        pitcherStackView.isUserInteractionEnabled = false
    }
    @IBAction func clickLose(_ sender: UIButton) {
        self.lose += 1.0
        sender.setTitle("패배\n\(Int(lose))", for: .normal)
        sender.titleLabel?.textAlignment = .center
        
        pitcherStackView.alpha = 0.5
        pitcherStackView.isUserInteractionEnabled = false
    }
    @IBAction func clickHold(_ sender: UIButton) {
        self.hold += 1.0
        sender.setTitle("홀드\n\(Int(hold))", for: .normal)
        sender.titleLabel?.textAlignment = .center
        
        pitcherStackView.alpha = 0.5
        pitcherStackView.isUserInteractionEnabled = false
    }
    @IBAction func clickSave(_ sender: UIButton) {
        self.save += 1.0
        sender.setTitle("세이브\n\(Int(save))", for: .normal)
        sender.titleLabel?.textAlignment = .center
        
        pitcherStackView.alpha = 0.5
        pitcherStackView.isUserInteractionEnabled = false
    }
    @IBAction func clickWalks(_ sender: UIButton) {
        self.walks += 1.0
        sender.setTitle("볼넷\n\(Int(walks))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickHitBatters(_ sender: UIButton) {
        self.hitBatters += 1.0
        sender.setTitle("사구\n\(Int(hitBatters))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickStrikeOuts(_ sender: UIButton) {
        self.strikeOuts += 1.0
        sender.setTitle("탈삼진\n\(Int(strikeOuts))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickER(_ sender: UIButton) {
        self.ER += 1.0
        sender.setTitle("자책점\n\(Int(ER))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickInning(_ sender: UIButton) {
        self.inningRemainder += 1.0
        if inningRemainder == 3.0 {
            self.inning += 1.0
            self.inningRemainder = 0.0
        }
        
        if self.inningRemainder == 0.0 {
            sender.setTitle("이닝\n\(Int(inning))", for: .normal)
        }
        else {
            sender.setTitle("이닝\n\(Int(inning)) \(Int(inningRemainder))/3", for: .normal)
        }
        
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickHits(_ sender: UIButton) {
        self.hits += 1.0
        sender.setTitle("피안타\n\(Int(hits))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickHomeRuns(_ sender: UIButton) {
        self.homeRuns += 1.0
        sender.setTitle("피홈런\n\(Int(homeRuns))", for: .normal)
        sender.titleLabel?.textAlignment = .center
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
