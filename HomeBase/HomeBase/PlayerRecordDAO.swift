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
    
    let playerRecordID = Expression<Int64>("playerRecordID")
    let playerID = Expression<Int64>("playerID")
    let scheduleID = Expression<Int64>("scheduleID")
    
    let singleHit = Expression<Double>("singleHit")
    let doubleHit = Expression<Double>("doubleHit")
    let tripleHit = Expression<Double>("tripleHit")
    let homeRun = Expression<Double>("homeRun")
    let baseOnBalls = Expression<Double>("baseOnBalls")
    let hitByPitch = Expression<Double>("hitByPitch")
    let strikeOut = Expression<Double>("strikeOut")
    let groundBall = Expression<Double>("groundBall")
    let flyBall = Expression<Double>("flyBall")
    let sacrificeHit = Expression<Double>("sacrificeHit")
    let stolenBase = Expression<Double>("stolenBase")
    
    let run = Expression<Double>("run")
    let RBI = Expression<Double>("RBI")
    
    let win = Expression<Double>("win")
    let lose = Expression<Double>("lose")
    let save = Expression<Double>("save")
    let hold = Expression<Double>("hold")
    let inning = Expression<Double>("inning")
    let hits = Expression<Double>("hits")
    let homeRuns = Expression<Double>("homeRuns")
    let walks = Expression<Double>("walks")
    let hitBatters = Expression<Double>("hitBatters")
    let strikeOuts = Expression<Double>("strikeOuts")
    let ER = Expression<Double>("ER")
    
    let player = PlayerDAO.shared.player
    let player_reference = PlayerDAO.shared.playerID
    
    let teamSchedule = TeamScheduleDAO.shared.teamSchedule
    let teamSchedule_reference = TeamScheduleDAO.shared.scheduleID

    let playerRecord: Table
    
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
                t.column(hitByPitch)
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

                t.foreignKey(playerID,
                             references: player, player_reference,
                             update: .cascade,
                             delete: .cascade)
                t.foreignKey(scheduleID,
                             references: teamSchedule, teamSchedule_reference,
                             update: .cascade ,
                             delete: .cascade)

            })
        } catch {
            print(error)
        }
    }

    func insert(playerRecordObject: PlayerRecord) {
        do {
            try DBManager.shared.db?.run(
                playerRecord.insert(
                    playerID <- playerRecordObject.playerID,
                    scheduleID <- playerRecordObject.scheduleID,
                    singleHit <- playerRecordObject.singleHit,
                    doubleHit <- playerRecordObject.doubleHit,
                    tripleHit <- playerRecordObject.tripleHit,
                    homeRun <- playerRecordObject.homeRun,
                    baseOnBalls <- playerRecordObject.baseOnBalls,
                    hitByPitch <- playerRecordObject.hitByPitch,
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

        } catch {
            print("Insert Error: \(error)")
        }
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
                    hitByPitch: record[hitByPitch],
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
                    homeRuns: record[homeRuns],
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
    
    func selectOnPlayer(id: Int64) -> PlayerRecord? {
        do {
            let count = try DBManager.shared.db?.scalar(playerRecord.select(playerRecordID.count))
            print(count!)
        } catch {
            print("Error: \(error)")
        }
        let totalRecord: PlayerRecord = PlayerRecord(
            playerRecordID: 0,
            playerID: id,
            scheduleID: 0)
        do {
            guard let query = try DBManager.shared.db?.prepare(playerRecord.filter(playerID == id)) else {
                return nil
            }
            for record in Array(query) {
                totalRecord.singleHit += record[singleHit]
                totalRecord.doubleHit += record[doubleHit]
                totalRecord.tripleHit += record[tripleHit]
                totalRecord.homeRun += record[homeRun]
                totalRecord.baseOnBalls += record[baseOnBalls]
                totalRecord.hitByPitch += record[hitByPitch]
                totalRecord.strikeOut += record[strikeOut]
                totalRecord.groundBall += record[groundBall]
                totalRecord.flyBall += record[flyBall]
                totalRecord.sacrificeHit += record[sacrificeHit]
                totalRecord.stolenBase += record[stolenBase]
                totalRecord.run += record[run]
                totalRecord.RBI += record[RBI]
                totalRecord.win += record[win]
                totalRecord.lose += record[lose]
                totalRecord.save += record[save]
                totalRecord.hold += record[hold]
                totalRecord.inning += record[inning]
                totalRecord.hits += record[hits]
                totalRecord.homeRuns += record[homeRuns]
                totalRecord.walks += record[walks]
                totalRecord.hitBatters += record[hitBatters]
                totalRecord.strikeOuts += record[strikeOuts]
                totalRecord.ER += record[ER]
            }
            
        } catch {
            print(error)
        }
        return totalRecord
        
    }
    
    func fetchPlayerRecordOnSchedule(playerID: Int64, scheduleID: Int64) -> PlayerRecord {
        var playerRecordItem = PlayerRecord(playerID: 0, scheduleID: 0)
        
        do {
            if let query = try DBManager.shared.db?.prepare(
                playerRecord.filter(self.playerID == playerID).filter(self.scheduleID == scheduleID)) {
                for record in Array(query) {
                    playerRecordItem = PlayerRecord(playerRecordID: record[self.playerRecordID],
                                                    playerID: record[self.playerID],
                                                    scheduleID: record[self.scheduleID],
                                                    singleHit: record[self.singleHit],
                                                    doubleHit: record[self.doubleHit],
                                                    tripleHit: record[self.tripleHit],
                                                    homeRun: record[self.homeRun],
                                                    baseOnBalls: record[self.baseOnBalls],
                                                    strikeOut: record[self.strikeOut],
                                                    groundBall: record[self.groundBall],
                                                    flyBall: record[self.flyBall],
                                                    sacrificeHit: record[self.sacrificeHit],
                                                    stolenBase: record[self.stolenBase],
                                                    run: record[self.run],
                                                    RBI: record[self.RBI],
                                                    win: record[self.win],
                                                    lose: record[self.lose],
                                                    save: record[self.save],
                                                    hold: record[self.hold],
                                                    inning: record[self.inning],
                                                    hits: record[self.hits],
                                                    homeRuns: record[self.homeRuns],
                                                    walks: record[self.walks],
                                                    hitBatters: record[self.hitBatters],
                                                    strikeOuts: record[self.strikeOuts],
                                                    ER: record[self.ER])
                }
            }
        } catch {
            print("Fetch Error : \(error)")
        }
        
        return playerRecordItem
    }
}
