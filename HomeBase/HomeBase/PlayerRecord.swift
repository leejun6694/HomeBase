//
//  PlayerRecord.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import Foundation

class PlayerRecord: NSObject {
    var playerRecordID: Int64
    var playerID: Int64
    var scheduleID: Int64
    
    var single: Double
    var double: Double
    var triple: Double
    var homeRun: Double
    var baseOnBalls: Double
    var strikeOut: Double
    var groundBall: Double
    var flyBall: Double
    var sacrificeHit: Double
    var stolenBase: Double
    
    var run: Double
    var RBI: Double
    
    var win: Double
    var lose: Double
    var save: Double
    var hold: Double
    var inning: Double
    var hits: Double
    var homeRuns: Double
    var walks: Double
    var hitBatters: Double
    var strikeOuts: Double
    var ER: Double
    
    
    init(playerRecordID: Int64 = 0,
         playerID: Int64,
         scheduleID: Int64,
         single: Double = 0,
         double: Double = 0,
         triple: Double = 0,
         homeRun: Double = 0,
         baseOnBalls: Double = 0,
         strikeOut: Double = 0,
         groundBall: Double = 0,
         flyBall: Double = 0,
         sacrificeHit: Double = 0,
         stolenBase: Double = 0,
         run: Double = 0,
         RBI: Double = 0,
         win: Double = 0,
         lose: Double = 0,
         save: Double = 0,
         hold: Double = 0,
         inning: Double = 0,
         hits: Double = 0,
         homeRuns: Double = 0,
         walks: Double = 0,
         hitBatters: Double = 0,
         strikeOuts: Double = 0,
         ER: Double = 0) {
        
        self.playerRecordID = playerRecordID
        self.playerID = playerID
        self.scheduleID = scheduleID
        
        self.single = single
        self.double = double
        self.triple = triple
        self.homeRun = homeRun
        self.baseOnBalls = baseOnBalls
        self.strikeOut = strikeOut
        self.groundBall = groundBall
        self.flyBall = flyBall
        self.sacrificeHit = sacrificeHit
        self.stolenBase = stolenBase
        
        self.run = run
        self.RBI = RBI
        self.win = win
        self.lose = lose
        self.save = save
        self.hold = hold
        self.inning = inning
        self.hits = hits
        self.homeRuns = homeRun
        self.walks = walks
        self.hitBatters = hitBatters
        self.strikeOuts = strikeOuts
        self.ER = ER
    }

}
