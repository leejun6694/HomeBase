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
    
    let playerID = Expression<Int64>("playerID")
    let name = Expression<String>("name")
    let backNumber = Expression<Int64>("backNumber")
    let position = Expression<String>("position")
    let player: Table
    
    private init() {
        player = Table("Player")
        do {
            try DBManager.shared.db?.run(player.create(ifNotExists: true) { t in
                t.column(playerID, primaryKey: .autoincrement)
                t.column(name)
                t.column(backNumber)
                t.column(position)
            })
        } catch {
            print(error)
        }
    }

    func insert(playerObject: Player) {
        do {
            try DBManager.shared.db?.run(player.insert(name <- playerObject.name, backNumber <- playerObject.backNumber, position <- playerObject.position ) )            
        } catch {
            print("Error: \(error)")
        }
        print(player.count)
    }
    
    func update(playerObject: Player) {
        do {
            let updatedPlayer = player.filter(playerID == playerObject.playerID)
            try DBManager.shared.db?.run(updatedPlayer.update(
                name <- playerObject.name,
                backNumber <- playerObject.backNumber,
                position <- playerObject.position ) )
        } catch {
            print("Error: \(error)")
        }

    }
    
    func countAll() -> Int {
        do {
            if let playerCount = try DBManager.shared.db?.scalar(player.count) {
                return playerCount
            }
        } catch {
            print("Count Error: \(error)")
        }
        
        return 0
    }
    
    func findName(findPlayerID: Int64) -> String {
        do {
            if let query = try DBManager.shared.db?.prepare(player.select(name).filter(self.playerID == findPlayerID)) {
                for playerName in Array(query) {
                    return playerName[name]
                }
            }
        } catch {
            print("Find Error : \(error)")
        }
        
        return ""
    }
    
    func selectAll() -> [Player]? {
        do {
            let count = try DBManager.shared.db?.scalar(player.select(playerID.count))
            print("count of player: \(count ?? 0)")
        } catch {
            print("Error: \(error)")
        }
        var playerArray = [Player]()
        do {
            guard let query = try DBManager.shared.db?.prepare(player.order(backNumber.asc)) else {
                return nil
            }
            for player in Array(query) {
                let playerItem = Player(id: player[playerID], name: player[name], backNumber: player[backNumber], position: player[position])
                playerArray.append(playerItem)
            }
            
        } catch {
            print(error)
        }
        return playerArray
    }
    
    func delete(id: Int64) {
        print("Before Delete")
        do {
            let count = try DBManager.shared.db?.scalar(player.select(playerID.count))
            print("count of player: \(count ?? 0)")
        } catch {
            print("Error: \(error)")
        }

        do {
            let join = player.join(PlayerRecordDAO.shared.playerRecord, on: playerID == PlayerRecordDAO.shared.playerID)
            let filter = join.filter(playerID == id)
            try DBManager.shared.db?.run(filter.delete())
        } catch {
            print("ERROR: \(error)")
        }
        print("After Delete")
        do {
            let count = try DBManager.shared.db?.scalar(player.select(playerID.count))
            print("count of player: \(count ?? 0)")
        } catch {
            print("Error: \(error)")
        }

    }
    
    func selectAllNumber() -> [Int] {
        var numberArray = [Int]()
        do {
            if let query = try DBManager.shared.db?.prepare(player.select(self.backNumber)) {
                for number in Array(query) {
                    numberArray.append(Int(number[backNumber]))
                }
            }
        } catch {
            print("Select Error : \(error)")
        }

        
        return numberArray
    }
}
