//
//  TeamSchedule.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import Foundation

class TeamSchedule: NSObject {
    
    let scheduleID: Int64
    let matchOpponent: String
    let matchDate: Date
    let matchPlace: String
    var homeScore: Int
    var awayScore: Int
    
    init(scheduleID: Int64 = 0,
         matchOpponent: String,
         matchDate: Date,
         matchPlace: String,
         homeScore: Int = -1,
         awayScore: Int = -1) {
        self.scheduleID = scheduleID
        self.matchOpponent = matchOpponent
        self.matchDate = matchDate
        self.matchPlace = matchPlace
        self.homeScore = homeScore
        self.awayScore = awayScore
    }
}
