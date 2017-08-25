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
    
    private let tableName = "PlayerRecord"
    
    typealias T = PlayerRecord
    let playerRecord: Table
    
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

    
    // create table
    private init() {
        playerRecord = Table(tableName)
        createTable()
    }
     
    func createTable() {
        let statement = playerRecord.create(ifNotExists: true) { t in
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
        }
        let result = DBManager.shared.createTable(statement)
        do {
            let _ = try DBManager.shared.db?.prepare("PRAGMA foreign_keys = ON")
        } catch {
            print(error)
        }
        switch result {
        case .ok:
            print("Create Player Record Table")
        case .error(_): break
        }
    }
    
    // insert
    
    func insert(item: T) {
        let query = playerRecord.insert(
            playerID <- item.playerID,
            scheduleID <- item.scheduleID,
            singleHit <- item.singleHit,
            doubleHit <- item.doubleHit,
            tripleHit <- item.tripleHit,
            homeRun <- item.homeRun,
            baseOnBalls <- item.baseOnBalls,
            hitByPitch <- item.hitByPitch,
            strikeOut <- item.strikeOut,
            groundBall <- item.groundBall,
            flyBall <- item.flyBall,
            sacrificeHit <- item.sacrificeHit,
            stolenBase <- item.stolenBase,
            run <- item.run,
            RBI <- item.RBI,
            win <- item.win,
            lose <- item.lose,
            save <- item.save,
            hold <- item.hold,
            inning <- item.inning,
            hits <- item.hits,
            homeRuns <- item.homeRuns,
            walks <- item.walks,
            hitBatters <- item.hitBatters,
            strikeOuts <- item.strikeOuts,
            ER <- item.ER
        )
        let result = DBManager.shared.insert(query)
        switch result {
        case .ok(_): break
        case .error(_): break
        }
    }
    
    // update
    
    func update(item: T) {
        let selected = playerRecord.filter(playerRecordID == item.playerRecordID)
        let query = selected.update(
            playerID <- item.playerID,
            scheduleID <- item.scheduleID,
            singleHit <- item.singleHit,
            doubleHit <- item.doubleHit,
            tripleHit <- item.tripleHit,
            homeRun <- item.homeRun,
            baseOnBalls <- item.baseOnBalls,
            hitByPitch <- item.hitByPitch,
            strikeOut <- item.strikeOut,
            groundBall <- item.groundBall,
            flyBall <- item.flyBall,
            sacrificeHit <- item.sacrificeHit,
            stolenBase <- item.stolenBase,
            run <- item.run,
            RBI <- item.RBI,
            win <- item.win,
            lose <- item.lose,
            save <- item.save,
            hold <- item.hold,
            inning <- item.inning,
            hits <- item.hits,
            homeRuns <- item.homeRuns,
            walks <- item.walks,
            hitBatters <- item.hitBatters,
            strikeOuts <- item.strikeOuts,
            ER <- item.ER)
        let result = DBManager.shared.update(query)
        switch result {
        case .ok(_): break
        case .error: break
        }
    }
    
    // select    
    // 스케줄 하나의 선수 기록
    func selectPlayerRecordOnSchedule(playerID: Int64, scheduleID: Int64) -> T? {
        var playerRecordItem = T (playerID: 0, scheduleID: 0)
        let filter = playerRecord.filter(self.playerID == playerID)
            .filter(self.scheduleID == scheduleID)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            for record in Array(rows) {
                playerRecordItem = T (
                    playerRecordID: record[self.playerRecordID],
                    playerID: record[self.playerID],
                    scheduleID: record[self.scheduleID],
                    singleHit: record[self.singleHit],
                    doubleHit: record[self.doubleHit],
                    tripleHit: record[self.tripleHit],
                    homeRun: record[self.homeRun],
                    baseOnBalls: record[self.baseOnBalls],
                    sacrificeHit: record[self.sacrificeHit],
                    strikeOut: record[self.strikeOut],
                    groundBall: record[self.groundBall],
                    flyBall: record[self.flyBall],
                    stolenBase: record[self.stolenBase],
                    run: record[self.run],
                    RBI: record[self.RBI],
                    win: record[self.win],
                    lose: record[self.lose],
                    hold: record[self.hold],
                    save: record[self.save],
                    walks: record[self.walks],
                    hitBatters: record[self.hitBatters],
                    hits: record[self.hits],
                    homeRuns: record[self.homeRuns],
                    inning: record[self.inning],
                    strikeOuts: record[self.strikeOuts],
                    ER: record[self.ER])
            }
            return playerRecordItem
        case .error: break
        }
        return nil
    }

    
    // 선수의 모든 기록
    func selectOnPlayer(id: Int64) -> T? {
        let totalRecord: T = T (playerRecordID: 0, playerID: id, scheduleID: 0)
        let selectedPlayer = playerRecord.filter(playerID == id)
        let resultSet = DBManager.shared.select(selectedPlayer)
        switch resultSet {
        case let .ok(rows):
            for record in Array(rows) {
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
            return totalRecord
        case .error: break
        }
        return nil
    }
    
    func selectSumOfBatterRecord(playerRecordID: Int64) -> Int {
        var sumOfBatterRecord: Int = 0
        let filter = playerRecord.filter(self.playerRecordID == playerRecordID).select(
            self.singleHit,
            self.doubleHit,
            self.tripleHit,
            self.homeRun,
            self.baseOnBalls,
            self.sacrificeHit,
            self.strikeOut,
            self.groundBall,
            self.flyBall,
            self.stolenBase,
            self.hitByPitch,
            self.run,
            self.RBI)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            for record in Array(rows) {
                sumOfBatterRecord += Int(record[self.singleHit])
                sumOfBatterRecord += Int(record[self.doubleHit])
                sumOfBatterRecord += Int(record[self.tripleHit])
                sumOfBatterRecord += Int(record[self.homeRun])
                sumOfBatterRecord += Int(record[self.baseOnBalls])
                sumOfBatterRecord += Int(record[self.sacrificeHit])
                sumOfBatterRecord += Int(record[self.strikeOut])
                sumOfBatterRecord += Int(record[self.groundBall])
                sumOfBatterRecord += Int(record[self.flyBall])
                sumOfBatterRecord += Int(record[self.stolenBase])
                sumOfBatterRecord += Int(record[self.hitByPitch])
                sumOfBatterRecord += Int(record[self.run])
                sumOfBatterRecord += Int(record[self.RBI])
            }
            return sumOfBatterRecord
        case .error: break
        }
        
        return sumOfBatterRecord
    }
    
    func selectSumOfPitcherRecord(playerRecordID: Int64) -> Int {
        var sumOfPitcherRecord: Int = 0
        let filter = playerRecord.filter(self.playerRecordID == playerRecordID).select(
            self.win,
            self.lose,
            self.hold,
            self.save,
            self.walks,
            self.hitBatters,
            self.hits,
            self.homeRuns,
            self.inning,
            self.strikeOuts,
            self.ER)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            for record in Array(rows) {
                sumOfPitcherRecord += Int(record[self.win])
                sumOfPitcherRecord += Int(record[self.lose])
                sumOfPitcherRecord += Int(record[self.hold])
                sumOfPitcherRecord += Int(record[self.save])
                sumOfPitcherRecord += Int(record[self.walks])
                sumOfPitcherRecord += Int(record[self.hitBatters])
                sumOfPitcherRecord += Int(record[self.hits])
                sumOfPitcherRecord += Int(record[self.homeRuns])
                sumOfPitcherRecord += Int(record[self.inning])
                sumOfPitcherRecord += Int(record[self.strikeOuts])
                sumOfPitcherRecord += Int(record[self.ER])
            }
            return sumOfPitcherRecord
        case .error: break
        }
        
        return sumOfPitcherRecord
    }
    
    func selectSumOfPlayerRecord(playerRecordID: Int64) -> Int {
        var sumOfPlayerRecord: Int = 0
        let filter = playerRecord.filter(self.playerRecordID == playerRecordID).select(
            self.singleHit,
            self.doubleHit,
            self.tripleHit,
            self.homeRun,
            self.baseOnBalls,
            self.sacrificeHit,
            self.strikeOut,
            self.groundBall,
            self.flyBall,
            self.stolenBase,
            self.hitByPitch,
            self.run,
            self.RBI,
            self.win,
            self.lose,
            self.hold,
            self.save,
            self.walks,
            self.hitBatters,
            self.hits,
            self.homeRuns,
            self.inning,
            self.strikeOuts,
            self.ER)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            for record in Array(rows) {
                sumOfPlayerRecord += Int(record[self.singleHit])
                sumOfPlayerRecord += Int(record[self.doubleHit])
                sumOfPlayerRecord += Int(record[self.tripleHit])
                sumOfPlayerRecord += Int(record[self.homeRun])
                sumOfPlayerRecord += Int(record[self.baseOnBalls])
                sumOfPlayerRecord += Int(record[self.sacrificeHit])
                sumOfPlayerRecord += Int(record[self.strikeOut])
                sumOfPlayerRecord += Int(record[self.groundBall])
                sumOfPlayerRecord += Int(record[self.flyBall])
                sumOfPlayerRecord += Int(record[self.stolenBase])
                sumOfPlayerRecord += Int(record[self.hitByPitch])
                sumOfPlayerRecord += Int(record[self.run])
                sumOfPlayerRecord += Int(record[self.RBI])
                sumOfPlayerRecord += Int(record[self.win])
                sumOfPlayerRecord += Int(record[self.lose])
                sumOfPlayerRecord += Int(record[self.hold])
                sumOfPlayerRecord += Int(record[self.save])
                sumOfPlayerRecord += Int(record[self.walks])
                sumOfPlayerRecord += Int(record[self.hitBatters])
                sumOfPlayerRecord += Int(record[self.hits])
                sumOfPlayerRecord += Int(record[self.homeRuns])
                sumOfPlayerRecord += Int(record[self.inning])
                sumOfPlayerRecord += Int(record[self.strikeOuts])
                sumOfPlayerRecord += Int(record[self.ER])
            }
            return sumOfPlayerRecord
        case .error: break
        }
        
        return sumOfPlayerRecord
    }
    
    func selectPlayerBatting() -> [Int64:Double]? {
        var playerBattingAverage = [Int64:Double]()
        let filter = playerRecord.select(
            self.playerID,
            self.singleHit.sum,
            self.doubleHit.sum,
            self.tripleHit.sum,
            self.homeRun.sum,
            self.strikeOut.sum,
            self.groundBall.sum,
            self.flyBall.sum).group(self.playerID)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            for batting in Array(rows) {
                let battingHits = Double(
                    batting[singleHit.sum]!
                        + batting[doubleHit.sum]!
                        + batting[tripleHit.sum]!
                        + batting[homeRun.sum]!)
                
                let battingOuts = Double(
                    batting[strikeOut.sum]!
                        + batting[groundBall.sum]!
                        + batting[flyBall.sum]!)                

                if (battingHits + battingOuts) != 0.0 {
                    playerBattingAverage[batting[playerID]] = battingHits / (battingHits + battingOuts)
                }
            }
            return playerBattingAverage
        case .error: break
        }
        return nil
    }
    
    func selectPlayerPitching() -> [Int64:Double]? {
        var playerERA = [Int64:Double]()
        let filter = playerRecord.select(
            self.playerID,
            self.ER.sum,
            self.inning.sum).group(self.playerID)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            for pitching in Array(rows) {
                if pitching[inning.sum] != 0.0 {
                    let pitchingERA = Double(pitching[ER.sum]!) * 9.0 / Double(pitching[inning.sum]!)
                    playerERA[pitching[playerID]] = pitchingERA
                }
            }
            return playerERA
        case .error: break
        }
        return nil
    }
    
    func selectHits() -> Double {
        var teamHit: Double = 0.0
        let filter = playerRecord.select(
            self.singleHit,
            self.doubleHit,
            self.tripleHit,
            self.homeRun)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            for hit in Array(rows) {
                teamHit += Double(hit[singleHit])
                teamHit += Double(hit[doubleHit])
                teamHit += Double(hit[tripleHit])
                teamHit += Double(hit[homeRun])
            }
        case .error: break
        }
        return teamHit
    }
    
    func selectOuts() -> Double {
        var teamOut: Double = 0.0
        let filter = playerRecord.select(self.strikeOut, self.groundBall, self.flyBall)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            for out in Array(rows) {
                teamOut += Double(out[strikeOut])
                teamOut += Double(out[groundBall])
                teamOut += Double(out[flyBall])
            }
           
        case .error: break
        }
        return teamOut
    }
    
    func selectER() -> Double {
        var teamER: Double = 0.0
        let filter = playerRecord.select(self.ER)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            for ERItem in Array(rows) {
                teamER += ERItem[ER]
                
            }
            
        case .error: break
        }
        return teamER
    }
    
    func selectInning() -> Double {
        var teamInning: Double = 0.0
        let filter = playerRecord.select(self.inning)
        let resultSet = DBManager.shared.select(filter)
        switch resultSet {
        case let .ok(rows):
            for ERItem in Array(rows) {
                teamInning += ERItem[inning]
            }
        case .error: break
        }
        return teamInning
    }
    
    // aggregate
    // 타자 출전 횟수
    func countPlayerBatterRecord(playerID: Int64) -> Int {
        let calculation = playerRecord.filter(self.playerID == playerID)
            .filter(self.inning == 0)
            .count
        let result = DBManager.shared.aggregate(calculation)
        switch result {
        case let .ok(value):
            return value
        case .error: break
        }
        return 0
    }
    
    // 투수 출전 횟수
    func countPlayerPitcherRecord(playerID: Int64) -> Int {
        let calculation = playerRecord.filter(self.playerID == playerID)
            .filter(self.inning != 0)
            .count
        let result = DBManager.shared.aggregate(calculation)
        switch result {
        case let .ok(value):
            return value
        case .error: break
        }        
        return 0
    }
    
}
