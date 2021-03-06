//
//  PlayerDAO.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import SQLite

class PlayerDAO {
    
    static let shared = PlayerDAO()
    
    private let tableName = "Player"
    typealias T = Player
    
    let player: Table
    let playerID = Expression<Int64>("playerID")
    let name = Expression<String>("name")
    let backNumber = Expression<Int>("backNumber")
    let position = Expression<String>("position")
    
    
    // create
    
    private init() {
        player = Table(tableName)
        let statement = player.create(ifNotExists: true) { t in
            t.column(playerID, primaryKey: .autoincrement)
            t.column(name)
            t.column(backNumber, unique: true)
            t.column(position)
        }
        let result = DBManager.shared.createTable(statement)
        switch result {
        case .ok:
            print("Complete Create Table")
        case .error(_): break
        }
    }

    // insert
    
    func insert(item: T) throws {
        let query = player.insert(
            name <- item.name,
            backNumber <- item.backNumber,
            position <- item.position)
        
        let result = DBManager.shared.insert(query)
        switch result {
        case .ok(_): break
        case let .error(error):
            throw error
        }
    }
    
    // update
    
    func update(item: T) throws {
        let selectedPlayer = player.filter(playerID == item.playerID)
        let query = selectedPlayer.update(
            name <- item.name,
            backNumber <- item.backNumber,
            position <- item.position)
        let result = DBManager.shared.update(query)
        switch result {
        case .ok(_): break
        case let .error(error):
            throw error
        }
    }
    
    // delete
    
    func delete(id: Int64) {
        let selectedPlayer = player.filter(playerID == id)
        let query = selectedPlayer.delete()
        let result = DBManager.shared.delete(query)
        switch result {
        case .ok(_): break
        case .error(_): break
        }
    }
    
    //select
    
    func selectAll() -> [T]? {
        var playerArray = [T]()
        let orderedTable = player.order(backNumber.asc)
        let resultSet = DBManager.shared.select(orderedTable)
        
        switch resultSet {
        case let .ok(rows):
            guard let rows = rows else { break }
            for player in Array(rows) {
                let playerItem = T (
                    id: player[playerID],
                    name: player[name],
                    backNumber: player[backNumber],
                    position: player[position])
                
                playerArray.append(playerItem)
            }
             return playerArray
        case .error(_):
            break
        }
        return nil
    }
    
    func selectName(findPlayerID: Int64) -> String {
        let filter = player.select(name).filter(self.playerID == findPlayerID)
        let result = DBManager.shared.select(filter)
        switch result {
        case let .ok(rows):
            guard let rows = rows else { break }
            for playerName in Array(rows) {
                return playerName[name]
            }
        case .error(_):
            break
        }
        return ""
    }

    func selectAllNumber() -> [Int]? {
        var numberArray = [Int]()
        let filter = player.select(self.backNumber)
        let result = DBManager.shared.select(filter)
        switch result {
        case let .ok(rows):
            guard let rows = rows else { break }
            for number in Array(rows) {
                numberArray.append(Int(number[backNumber]))
            }
            return numberArray
        case .error(_): break
        }
        return nil
    }
    
    // aggregete
    
    func countAll() -> Int {
        let result = DBManager.shared.aggregate(player.count)
        switch result {
        case let .ok(value):
            guard let value = value else { break }
            return value
        case .error(_):
            break
        }
        return 0
    }
    
}
