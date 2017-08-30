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
    
    private let tableName = "TeamSchedule"
    typealias T = TeamSchedule
    
    let teamSchedule: Table
    let scheduleID = Expression<Int64>("scheduleID")
    let matchOpponent = Expression<String>("matchOpponent")
    let matchDate = Expression<Date>("matchDate")
    let matchPlace = Expression<String>("matchPlace")
    let homeScore = Expression<Int>("homeScore")
    let awayScore = Expression<Int>("awayScore")
    
    private init() {
        teamSchedule = Table(tableName)
        let statement = teamSchedule.create(ifNotExists: true) {t in
            t.column(scheduleID, primaryKey: .autoincrement)
            t.column(matchOpponent)
            t.column(matchDate)
            t.column(matchPlace)
            t.column(homeScore)
            t.column(awayScore)
        }
        let result = DBManager.shared.createTable(statement)
        switch result {
        case .ok:
            print("Schedule Table Created")
        case .error(_): break
        }
    }
    
    // MARK: Functions

    // insert
    
    @discardableResult func insert(item: T) -> Int64? {
        let query = teamSchedule.insert(
            matchOpponent <- item.matchOpponent,
            matchDate <- item.matchDate,
            matchPlace <- item.matchPlace,
            homeScore <- -1,
            awayScore <- -1)
        
        let result = DBManager.shared.insert(query)
        switch result {
        case let .ok(id):
            return id
        case .error(_): break
        }
        return nil
    }
    
    // update
    
    func update(item: T) {
        let selected = teamSchedule.filter(scheduleID == item.scheduleID)
        let query = selected.update(
            matchOpponent <- item.matchOpponent,
            matchDate <- item.matchDate,
            matchPlace <- item.matchPlace)
        let result = DBManager.shared.update(query)
        switch result {
        case .ok(_): break
        case .error: break
        }
        
    }
    
    func updateHomeScore(updateScheduleID: Int64, _ updateHomeScore: Int) {
        let selected = teamSchedule.filter(self.scheduleID == updateScheduleID)
            .update(self.homeScore <- updateHomeScore)
        let result = DBManager.shared.update(selected)
        switch result {
        case .ok(_): break
        case .error: break
        }
    }
    
    func updateAwayScore(updateScheduleID: Int64, _ updateAwayScore: Int) {
        let selected = teamSchedule.filter(self.scheduleID == updateScheduleID)
            .update(self.awayScore <- updateAwayScore)
        let result = DBManager.shared.update(selected)
        switch result {
        case .ok(_): break
        case .error: break
        }
    }
    
    // delete
    
    func delete(id: Int64) {
        let selectedSchedule = teamSchedule.filter(scheduleID == id)
        let query = selectedSchedule.delete()
        let result = DBManager.shared.delete(query)
        switch result {
        case .ok(_): break
        case .error: break
        }
    }

    // select
    
    func selectAllColumn() -> [T]? {
        var teamScheduleArray = [T]()
        let orderdSchedule = teamSchedule.order(matchDate.desc)
        let resultSet = DBManager.shared.select(orderdSchedule)
        switch resultSet {
        case let .ok(rows):
            guard let rows = rows else { break }
            for schedule in Array(rows) {
                let scheduleItem = T(
                    scheduleID: schedule[scheduleID],
                    matchOpponent: schedule[matchOpponent],
                    matchDate: schedule[matchDate],
                    matchPlace: schedule[matchPlace],
                    homeScore: schedule[homeScore],
                    awayScore: schedule[awayScore])
                
                teamScheduleArray.append(scheduleItem)
            }
            return teamScheduleArray
        case .error: break
        }
        return nil
    }
    
    func selectMatchResult() -> TeamRecord{
        let teamRecord = TeamRecord()
        let filter = teamSchedule.select(self.homeScore, self.awayScore)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            guard let rows = rows else { break }
            for result in Array(rows) {
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
            
        case .error: break
        }
        return teamRecord
    }
    
    // aggregate
    
    func countAll() -> Int {
        let result = DBManager.shared.aggregate(teamSchedule.count)
        switch result {
        case let .ok(value):
            guard let value = value else { break }
            return value
        case .error: break
        }
        return 0
    }

}
