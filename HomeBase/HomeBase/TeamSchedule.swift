//
//  TeamSchedule.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import Foundation

class TeamSchedule: NSObject {
    
    // MARK: Properties
    let scheduleID: Int64
    let matchOpponent: String
    let matchDate: Date
    let matchPlace: String
    var homeScore: Int64
    var awayScore: Int64
    
    // MARK: Initializer
    
    init (scheduleID: Int64 = 0, matchOpponent: String, matchDate: Date, matchPlace: String) {
        self.scheduleID = scheduleID
        self.matchOpponent = matchOpponent
        self.matchDate = matchDate
        self.matchPlace = matchPlace
        self.homeScore = -1
        self.awayScore = -1
    }
}
