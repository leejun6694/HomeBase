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
    
    @IBOutlet var pitcherView: UIView!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var pitcherStackView: UIStackView!
    
    var row: Int!
    var playerID: Int64!
    var scheduleID: Int64!
    
    private var win: Double = 0.0
    private var lose: Double = 0.0
    private var hold: Double = 0.0
    private var save: Double = 0.0
    private var inning: Double = 0.0
    private var inningRemainder: Double = 0.0
    private var hits: Double = 0.0
    private var homeRuns: Double = 0.0
    private var walks: Double = 0.0
    private var hitBatters: Double = 0.0
    private var strikeOuts: Double = 0.0
    private var ER: Double = 0.0
    
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
            
            let playerRecord = PlayerRecord(
                playerID: self.playerID,
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
            
            PlayerRecordDAO.shared.insert(playerRecordObject: playerRecord)
        }
    }
    
    // MARK: Actions
    
    @IBAction func backgroundViewDidTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: Record Buttons
    
    @IBAction func winDidTapped(_ sender: UIButton) {
        self.win += 1.0
        sender.setTitle("승리\n\(Int(win))", for: .normal)
        sender.titleLabel?.textAlignment = .center
        
        pitcherStackView.alpha = 0.5
        pitcherStackView.isUserInteractionEnabled = false
    }
    @IBAction func loseDidTapped(_ sender: UIButton) {
        self.lose += 1.0
        sender.setTitle("패배\n\(Int(lose))", for: .normal)
        sender.titleLabel?.textAlignment = .center
        
        pitcherStackView.alpha = 0.5
        pitcherStackView.isUserInteractionEnabled = false
    }
    @IBAction func holdDidTapped(_ sender: UIButton) {
        self.hold += 1.0
        sender.setTitle("홀드\n\(Int(hold))", for: .normal)
        sender.titleLabel?.textAlignment = .center
        
        pitcherStackView.alpha = 0.5
        pitcherStackView.isUserInteractionEnabled = false
    }
    @IBAction func saveDidTapped(_ sender: UIButton) {
        self.save += 1.0
        sender.setTitle("세이브\n\(Int(save))", for: .normal)
        sender.titleLabel?.textAlignment = .center
        
        pitcherStackView.alpha = 0.5
        pitcherStackView.isUserInteractionEnabled = false
    }
    @IBAction func walksDidTapped(_ sender: UIButton) {
        self.walks += 1.0
        sender.setTitle("볼넷\n\(Int(walks))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func hitBattersDidTapped(_ sender: UIButton) {
        self.hitBatters += 1.0
        sender.setTitle("사구\n\(Int(hitBatters))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func strikeOutsDidTapped(_ sender: UIButton) {
        self.strikeOuts += 1.0
        sender.setTitle("탈삼진\n\(Int(strikeOuts))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func ERDidTapped(_ sender: UIButton) {
        self.ER += 1.0
        sender.setTitle("자책점\n\(Int(ER))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func inningDidTapped(_ sender: UIButton) {
        self.inningRemainder += 1.0
        if inningRemainder == 3.0 {
            self.inning += 1.0
            self.inningRemainder = 0.0
        }
        
        if self.inningRemainder == 0.0 {
            sender.setTitle("이닝\n\(Int(inning))", for: .normal)
        } else {
            sender.setTitle("이닝\n\(Int(inning)) \(Int(inningRemainder))/3", for: .normal)
        }
        
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func hitsDidTapped(_ sender: UIButton) {
        self.hits += 1.0
        sender.setTitle("피안타\n\(Int(hits))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func homeRunsDidTapped(_ sender: UIButton) {
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
