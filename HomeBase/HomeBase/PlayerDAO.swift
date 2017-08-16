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
            do {
                let select = player.select(playerID, name)
                let prepare = try DBManager.shared.db?.prepare(select)
                for user in prepare!  {
                    print("id: \(user[playerID]), name: \(user[name])")
                }
                
            } catch {
                print("Error: \(error)")
            }
            
        } catch {
            print("Error: \(error)")
        }
        print(player.count)
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
    
    func selectAll() -> [Player]? {
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
        do {
            let filter = player.filter(playerID == id)
            try DBManager.shared.db?.run(filter.delete())
        } catch {
            print("ERROR: \(error)")
        }
    }
}
