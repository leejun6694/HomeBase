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
    
    var row: Int!
    var playerID: Int64!
    var scheduleID: Int64!
    
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
    
    // MARK: Actions
    
    @IBAction func clickBackgroundView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindBatterToDetail" {
            print("batter record player id = \(self.playerID)")
            let playerRecord = PlayerRecord(playerID: self.playerID,
                                            scheduleID: self.scheduleID,
                                            singleHit: self.singleHit,
                                            doubleHit: self.doubleHit,
                                            tripleHit: self.tripleHit,
                                            homeRun: self.homeRun,
                                            baseOnBalls: self.baseOnBalls,
                                            strikeOut: self.strikeOut,
                                            groundBall: self.groundBall,
                                            flyBall: self.flyBall,
                                            sacrificeHit: self.sacrificeHit,
                                            stolenBase: self.stolenBase,
                                            run: self.run,
                                            RBI: self.RBI)
            
            PlayerRecordDAO.shared.insert(item: playerRecord)
        }
    }
    
    // MARK: Record Buttons
    
    @IBAction func clickSingleHit(_ sender: UIButton) {
        self.singleHit += 1
        sender.setTitle("1루타\n\(Int(singleHit))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickDoubleHit(_ sender: UIButton) {
        self.doubleHit += 1
        sender.setTitle("2루타\n\(Int(doubleHit))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickTripleHit(_ sender: UIButton) {
        self.tripleHit += 1
        sender.setTitle("3루타\n\(Int(tripleHit))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickHomeRun(_ sender: UIButton) {
        self.homeRun += 1
        sender.setTitle("홈런\n\(Int(homeRun))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickBaseOnBalls(_ sender: UIButton) {
        self.baseOnBalls += 1
        sender.setTitle("볼넷\n\(Int(baseOnBalls))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickSacrificeHit(_ sender: UIButton) {
        self.sacrificeHit += 1
        sender.setTitle("희생타\n\(Int(sacrificeHit))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickStrikeOut(_ sender: UIButton) {
        self.strikeOut += 1
        sender.setTitle("삼진\n\(Int(strikeOut))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickGroundBall(_ sender: UIButton) {
        self.groundBall += 1
        sender.setTitle("땅볼\n\(Int(groundBall))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickFlyBall(_ sender: UIButton) {
        self.flyBall += 1
        sender.setTitle("뜬공\n\(Int(flyBall))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickStolenBase(_ sender: UIButton) {
        self.stolenBase += 1
        sender.setTitle("도루\n\(Int(stolenBase))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickHitByPitch(_ sender: UIButton) {
        self.hitByPitch += 1
        sender.setTitle("사구\n\(Int(hitByPitch))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickRun(_ sender: UIButton) {
        self.run += 1
        sender.setTitle("득점\n\(Int(run))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    @IBAction func clickRBI(_ sender: UIButton) {
        self.RBI += 1
        sender.setTitle("타점\n\(Int(RBI))", for: .normal)
        sender.titleLabel?.textAlignment = .center
    }
    
}
