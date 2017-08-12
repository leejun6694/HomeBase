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
    
    let matchOpponent: String
    let matchDate: Date
    let matchPlace: String
    var homeScore: Int64?
    var opponentScore: Int64?
    
    // MARK: Initializer
    
    init (matchOpponent: String, matchDate: Date, matchPlace: String) {
        self.matchOpponent = matchOpponent
        self.matchDate = matchDate
        self.matchPlace = matchPlace
        self.homeScore = 0
        self.opponentScore = 0
    }
}
