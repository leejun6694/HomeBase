//
//  PlayerDAO.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import SQLite

class PlayerDAO {
    
    static var shared = PlayerDAO()
    
    private let playerID = Expression<Int64>("playerID")
    private let name = Expression<String>("name")
    private let backNumber = Expression<Int64>("backNumber")
    private let position = Expression<String>("position")
    private let player: Table
    
    private init() {
        player = Table("Player")
        do {
            try DBManager.shared.db?.run(player.create(ifNotExists: true) { t in
                t.column(playerID, primaryKey: .autoincrement)
                t.column(backNumber)
                t.column(position)
            })
        } catch {
            print(error)
        }
    }
    
    func getTable() -> Table {
        return player
    }
    
    func getReference() -> Expression<Int64> {
        return playerID
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
    
    func selectAll() -> [Player]? {
        var playerArray = [Player]()
        do {
            guard let query = try DBManager.shared.db?.prepare(player.order(backNumber.asc)) else {
                return nil
            }
            for player in Array(query) {
                let p = Player(id: player[playerID], name: player[name], backNumber: player[backNumber], position: player[position])
                playerArray.append(p)
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
