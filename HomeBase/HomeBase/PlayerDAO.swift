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
    
    static var playerShared = [Player]()
    
    let playerID = Expression<Int64>("playerID")
    var name = Expression<String>("name")
    var backNumber = Expression<Int64>("backNumber")
    var position = Expression<String>("position")
    
    let player: Table = {
        let player = Table("Player")
        return player
    }()
    
    init() {
        createTable()
    }
    
    func createTable() {
        do {
            try DBManager.shared.db?.run(player.create(ifNotExists: true) { t in
                t.column(playerID, primaryKey: .autoincrement)
                t.column(backNumber)
                t.column(position)
            })
        } catch {
            print(error)
        }
        print("create table")
    }
    
    
    func insert(_name: String, _backNumber: Int64, _position: String) {
        do {
            try DBManager.shared.db?.run(player.insert(name <- _name, backNumber <- _backNumber, position <- _position))
            do {
                let select = player.select(playerID, name)
                let prepare = try DBManager.shared.db?.prepare(select)
                for user in prepare!  {
                    print("id: \(user[playerID]), name: \(user[name])")
                }
                
            } catch {
                
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
}
