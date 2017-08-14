//
//  TeamInfoDAO.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import SQLite

class TeamInfoDAO {
    
    static let shared = TeamInfoDAO()
    
    // MARK: Properties
    
    private let teamName = Expression<String>("teamName")
    private let teamImagePath = Expression<String>("teamImagePath")
    
    private let teamInfo: Table
    
    private init() {
        
        teamInfo = Table("TeamInfo")
        
        do {
            try DBManager.shared.db?.run(teamInfo.create(ifNotExists: true) {
                t in
                
                t.column(teamName)
                t.column(teamImagePath)
            })
        } catch {
            print("Error : \(error)")
        }
    }
    
    // MARK: Functions
    
    func getTable() -> Table {
        return teamInfo
    }
    
    func insert(insertTeamInfo: TeamInfo) {
        do {
            try DBManager.shared.db?.run(teamInfo.insert(
                teamName <- insertTeamInfo.teamName,
                teamImagePath <- insertTeamInfo.teamImagePath))
        } catch {
            print("Insert Error : \(error)")
        }
    }
}
