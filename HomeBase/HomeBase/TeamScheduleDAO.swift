//
//  TeamScheduleDAO.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import SQLite

class TeamScheduleDAO {
    
    static let shared = TeamScheduleDAO()
    
    // MARK: Properties
    
    let matchOpponent = Expression<String>("matchOpponent")
    let matchDate = Expression<Date>("matchDate")
    let matchPlace = Expression<String>("matchPlace")
    let homeScore = Expression<Int64>("homeScore")
    let opponentScore = Expression<Int64>("opponentScore")
    
    let teamSchedule: Table = {
        let teamSchedule = Table("TeamSchedule")
        
        return teamSchedule
    }()
    
    // MARK: Functions
    
    func createTable() {
        do {
            try DBManager.shared.db?.run(teamSchedule.create(ifNotExists: true) {
                t in
                
                t.column(matchOpponent)
                t.column(matchDate)
                t.column(matchPlace)
                t.column(homeScore)
                t.column(opponentScore)
            })
        } catch {
            print("ERROR : Create TeamSchedule Table")
        }
        print("Create TeamSchedule Table")
    }
    
    func insert(insertTeamSchedule: TeamSchedule) {
        do {
            try DBManager.shared.db?.run(teamSchedule.insert(matchOpponent <- insertTeamSchedule.matchOpponent, matchDate <- insertTeamSchedule.matchDate, matchPlace <- insertTeamSchedule.matchPlace, homeScore <- 0, opponentScore <- 0))
            
            print("Insert TeamSchedule")
            
        } catch {
            print("Error: \(error)")
        }
    }
}
