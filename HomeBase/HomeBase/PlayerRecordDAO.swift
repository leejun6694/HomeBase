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
            return playerRecordItem
        case .error: break
        }
        return nil
    }

    
    // 선수의 모든 기록
    func selectOnPlayer(id: Int64) -> T? {
        do {
            let count = try DBManager.shared.db?.scalar(playerRecord.select(playerID.count))
            print("count of playerRecord: \(count ?? 0)")
        } catch {
            print("Error: \(error)")
        }
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
                print("player id: \(batting[playerID])")
                
                let battingHits = Double(
                    batting[singleHit.sum]!
                        + batting[doubleHit.sum]!
                        + batting[tripleHit.sum]!
                        + batting[homeRun.sum]!)
                print(battingHits)
                
                let battingOuts = Double(
                    batting[strikeOut.sum]!
                        + batting[groundBall.sum]!
                        + batting[flyBall.sum]!)
                print(battingOuts)
                
                if battingHits != 0.0, battingOuts != 0.0 {
                    print("둘 다 0이 아니다")
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
