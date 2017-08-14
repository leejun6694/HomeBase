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
    
    let scheduleID = Expression<Int64>("scheduleID")
    let matchOpponent = Expression<String>("matchOpponent")
    let matchDate = Expression<Date>("matchDate")
    let matchPlace = Expression<String>("matchPlace")
    let homeScore = Expression<Int64>("homeScore")
    let awayScore = Expression<Int64>("awayScore")
    
    let teamSchedule: Table = {
        let teamSchedule = Table("TeamSchedule")
        
        return teamSchedule
    }()
    
    // MARK: Functions
    
    func createTable() {
        do {
            try DBManager.shared.db?.run(teamSchedule.create(ifNotExists: true) {
                t in
                
                t.column(scheduleID, primaryKey: .autoincrement)
                t.column(matchOpponent)
                t.column(matchDate)
                t.column(matchPlace)
                t.column(homeScore)
                t.column(awayScore)
            })
        } catch {
            print("ERROR : Create TeamSchedule Table")
        }
    }
    
    func insert(insertTeamSchedule: TeamSchedule) {
        do {
            try DBManager.shared.db?.run(teamSchedule.insert(matchOpponent <- insertTeamSchedule.matchOpponent, matchDate <- insertTeamSchedule.matchDate, matchPlace <- insertTeamSchedule.matchPlace, homeScore <- -1, awayScore <- -1))
        } catch {
            print("Insert Error: \(error)")
        }
    }
    
    func findHomeScore(findScheduleID: Int64) -> Int64 {
        do {
            let query = teamSchedule.filter(self.scheduleID == findScheduleID)
            let items = try DBManager.shared.db?.prepare(query)
            for item in items! {
                return item[homeScore]
            }
        } catch {
            print("Find Error: \(error)")
        }
        return 0
    }
    
    func findAwayScore(findScheduleID: Int64) -> Int64 {
        do {
            let query = teamSchedule.filter(self.scheduleID == findScheduleID)
            let items = try DBManager.shared.db?.prepare(query)
            for item in items! {
                return item[awayScore]
            }
        } catch {
            print("Find Error: \(error)")
        }
        return 0
    }

    func updateHomeScore(updateScheduleID: Int64, _ updateHomeScore: Int64) {
        do {
            try DBManager.shared.db?.run(teamSchedule.filter(self.scheduleID == updateScheduleID).update(self.homeScore <- updateHomeScore))
        } catch {
            print("Update Error: \(error)")
        }
    }
    
    func updateAwayScore(updateScheduleID: Int64, _ updateAwayScore: Int64) {
        do {
            try DBManager.shared.db?.run(teamSchedule.filter(self.scheduleID == updateScheduleID).update(self.awayScore <- updateAwayScore))
        } catch {
            print("Update Error: \(error)")
        }
    }
}
