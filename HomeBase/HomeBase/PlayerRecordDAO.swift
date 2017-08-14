//
//  PlayerRecordDAO.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import SQLite

class PlayerRecordDAO {
    
    static let shared = PlayerRecordDAO()
    
    private let playerRecordID = Expression<Int64>("playerRecordID")
    private let playerID = Expression<Int64>("playerID")
    private let scheduleID = Expression<Int64>("scheduleID")
    
    private let singleHit = Expression<Double>("singleHit")
    private let doubleHit = Expression<Double>("doubleHit")
    private let tripleHit = Expression<Double>("tripleHit")
    private let homeRun = Expression<Double>("homeRun")
    private let baseOnBalls = Expression<Double>("baseOnBalls")
    private let strikeOut = Expression<Double>("strikeOut")
    private let groundBall = Expression<Double>("groundBall")
    private let flyBall = Expression<Double>("flyBall")
    private let sacrificeHit = Expression<Double>("sacrificeHit")
    private let stolenBase = Expression<Double>("stolenBase")
    
    private let run = Expression<Double>("run")
    private let RBI = Expression<Double>("RBI")
    
    private let win = Expression<Double>("win")
    private let lose = Expression<Double>("lose")
    private let save = Expression<Double>("save")
    private let hold = Expression<Double>("hold")
    private let inning = Expression<Double>("inning")
    private let hits = Expression<Double>("hits")
    private let homeRuns = Expression<Double>("homeRuns")
    private let walks = Expression<Double>("walks")
    private let hitBatters = Expression<Double>("hitBatters")
    private let strikeOuts = Expression<Double>("strikeOuts")
    private let ER = Expression<Double>("ER")
    
    private let player = PlayerDAO.shared.getTable()
    private let player_reference = PlayerDAO.shared.getReference()
    
    private let teamSchedule = TeamScheduleDAO.shared.getTable()
    private let teamSchedule_reference = TeamScheduleDAO.shared.getReference()

    private let playerRecord: Table
    
    private init() {
        playerRecord = Table("PlayerRecord")
        createTable()
    }
    
    func createTable() {
        do {
            try DBManager.shared.db?.run(playerRecord.create(ifNotExists: true) { t in
                t.column(playerRecordID, primaryKey: .autoincrement)
                t.column(playerID)
                t.column(scheduleID)
                t.column(singleHit)
                t.column(doubleHit)
                t.column(tripleHit)
                t.column(homeRun)
                t.column(baseOnBalls)
                t.column(strikeOut)
                t.column(groundBall)
                t.column(flyBall)
                t.column(sacrificeHit)
                t.column(stolenBase)
                t.column(run)
                t.column(RBI)
                t.column(win)
                t.column(lose)
                t.column(save)
                t.column(hold)
                t.column(inning)
                t.column(hits)
                t.column(homeRuns)
                t.column(walks)
                t.column(hitBatters)
                t.column(strikeOuts)
                t.column(ER)
                t.foreignKey(playerID, references: player, player_reference, update: .cascade , delete: .cascade)
                t.foreignKey(scheduleID, references: teamSchedule, teamSchedule_reference , update: .cascade , delete: .cascade)
            })
        } catch {
            print(error)
        }
        print("create table")
    }

    func insert(playerRecordObject: PlayerRecord) {
        do {
            try DBManager.shared.db?.run(
                player.insert(
                    singleHit <- playerRecordObject.singleHit,
                    doubleHit <- playerRecordObject.doubleHit,
                    tripleHit <- playerRecordObject.tripleHit,
                    homeRun <- playerRecordObject.homeRun,
                    baseOnBalls <- playerRecordObject.baseOnBalls,
                    strikeOut <- playerRecordObject.strikeOut,
                    groundBall <- playerRecordObject.groundBall,
                    flyBall <- playerRecordObject.flyBall,
                    sacrificeHit <- playerRecordObject.sacrificeHit,
                    stolenBase <- playerRecordObject.stolenBase,
                    run <- playerRecordObject.run,
                    RBI <- playerRecordObject.RBI,
                    win <- playerRecordObject.win,
                    lose <- playerRecordObject.lose,
                    save <- playerRecordObject.save,
                    hold <- playerRecordObject.hold,
                    inning <- playerRecordObject.inning,
                    hits <- playerRecordObject.hits,
                    homeRuns <- playerRecordObject.homeRuns,
                    walks <- playerRecordObject.walks,
                    hitBatters <- playerRecordObject.hitBatters,
                    strikeOuts <- playerRecordObject.strikeOuts,
                    ER <- playerRecordObject.ER ))
            do {
                let select = player.select(playerID, doubleHit)
                let prepare = try DBManager.shared.db?.prepare(select)
                for user in prepare!  {
                    print("id: \(user[playerID]), name: \(user[doubleHit])")
                }
                
            } catch {
                
            }
            
        } catch {
            print("Error: \(error)")
        }
        print(player.count)
    }
    
    func selectOnSchedule(id: Int64) -> [PlayerRecord]? {
        do {
            let count = try DBManager.shared.db?.scalar(playerRecord.select(playerRecordID.count))
            print(count!)
        } catch {
            print("Error: \(error)")
        }
        var playerArrayOnSchedule = [PlayerRecord]()
        do {
            guard let query = try DBManager.shared.db?.prepare(playerRecord.filter(scheduleID == id)) else {
                return nil
            }
            for record in Array(query) {
                let recordObject = PlayerRecord(
                    playerRecordID: record[playerRecordID],
                    playerID: record[playerID],
                    scheduleID: record[scheduleID],
                    singleHit: record[singleHit],
                    doubleHit: record[doubleHit],
                    tripleHit: record[tripleHit],
                    homeRun: record[homeRun],
                    baseOnBalls: record[baseOnBalls],
                    strikeOut: record[strikeOut],
                    groundBall: record[groundBall],
                    flyBall: record[flyBall],
                    sacrificeHit: record[sacrificeHit],
                    stolenBase: record[stolenBase],
                    run: record[run],
                    RBI: record[RBI],
                    win: record[win],
                    lose: record[lose],
                    save: record[save],
                    hold: record[hold],
                    inning: record[inning],
                    hits: record[hits],
                    homeRuns: record[homeRun],
                    walks: record[walks],
                    hitBatters: record[hitBatters],
                    strikeOuts: record[strikeOuts],
                    ER: record[ER])
                playerArrayOnSchedule.append(recordObject)
            }
            
        } catch {
            print(error)
        }
        return playerArrayOnSchedule
    }
    
    func selectOnPlayer(id: Int64) -> [PlayerRecord]? {
        do {
            let count = try DBManager.shared.db?.scalar(playerRecord.select(playerRecordID.count))
            print(count!)
        } catch {
            print("Error: \(error)")
        }
        var playerArrayOnSchedule = [PlayerRecord]()
        do {
            guard let query = try DBManager.shared.db?.prepare(playerRecord.filter(playerID == id)) else {
                return nil
            }
            for record in Array(query) {
                print("playerID: \(record[playerID]), scheduleID: \(record[scheduleID]), tripleHit: \(record[tripleHit])")
                let p = PlayerRecord(playerID: record[playerID], scheduleID: record[scheduleID], tripleHit: record[tripleHit])
                playerArrayOnSchedule.append(p)
            }
            
        } catch {
            print(error)
        }
        return playerArrayOnSchedule
        
    }


}
