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
    
    let teamSchedule: Table
    
    private init() {
        
        teamSchedule = Table("TeamSchedule")
        
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
    
    // MARK: Functions

    func insert(insertTeamSchedule: TeamSchedule) {
        do {
            try DBManager.shared.db?.run(teamSchedule.insert(
                matchOpponent <- insertTeamSchedule.matchOpponent,
                matchDate <- insertTeamSchedule.matchDate,
                matchPlace <- insertTeamSchedule.matchPlace,
                homeScore <- -1,
                awayScore <- -1))
        } catch {
            print("Insert Error: \(error)")
        }
    }
    
    func findAllColumn() -> [TeamSchedule] {
        var teamScheduleArray = [TeamSchedule]()
        
        do {
            if let query = try DBManager.shared.db?.prepare(teamSchedule.order(matchDate.desc)) {
                for schedule in Array(query) {
                    let scheduleItem = TeamSchedule(
                        scheduleID: schedule[scheduleID],
                        matchOpponent: schedule[matchOpponent],
                        matchDate: schedule[matchDate],
                        matchPlace: schedule[matchPlace],
                        homeScore: schedule[homeScore],
                        awayScore: schedule[awayScore])
                    
                    teamScheduleArray.append(scheduleItem)
                }
            }
        } catch {
            print("Find Error : \(error)")
        }
        
        return teamScheduleArray
    }
    
    func fetchMatchResult() -> TeamRecord {
        let teamRecord = TeamRecord()
        
        do {
            if let query = try DBManager.shared.db?.prepare(teamSchedule.select(self.homeScore, self.awayScore)) {
                for result in Array(query) {
                    if result[homeScore] == -1 || result[awayScore] == -1 {
                        continue
                    }
                    
                    if result[homeScore] > result[awayScore] {
                        teamRecord.win += 1
                    }
                    else if result[homeScore] == result[awayScore] {
                        teamRecord.draw += 1
                    }
                    else {
                        teamRecord.lose += 1
                    }
                }
            }
        } catch {
            print("Fetch Error : \(error)")
        }
        
        return teamRecord
    }
    
    func countAll() -> Int {
        do {
            if let scheduleCount = try DBManager.shared.db?.scalar(teamSchedule.count) {
                return scheduleCount
            }
        } catch {
            print("Count Error: \(error)")
        }
        
        return 0
    }

    func updateHomeScore(updateScheduleID: Int64, _ updateHomeScore: Int64) {
        do {
            try DBManager.shared.db?.run(teamSchedule.filter(
                self.scheduleID == updateScheduleID).update(self.homeScore <- updateHomeScore))
        } catch {
            print("Update Error: \(error)")
        }
    }
    
    func updateAwayScore(updateScheduleID: Int64, _ updateAwayScore: Int64) {
        do {
            try DBManager.shared.db?.run(teamSchedule.filter(
                self.scheduleID == updateScheduleID).update(self.awayScore <- updateAwayScore))
        } catch {
            print("Update Error: \(error)")
        }
    }
}
