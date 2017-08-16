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
    
    let teamName = Expression<String>("teamName")
    let teamImagePath = Expression<String>("teamImagePath")
    
    let teamInfo: Table
    
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
    
    func insert(insertTeamInfo: TeamInfo) {
        do {
            try DBManager.shared.db?.run(teamInfo.insert(
                teamName <- insertTeamInfo.teamName,
                teamImagePath <- insertTeamInfo.teamImagePath))
        } catch {
            print("Insert Error : \(error)")
        }
    }
    
    func fetch() -> TeamInfo {
        do {
            if let query = try DBManager.shared.db?.prepare(teamInfo) {
                for teamInfos in Array(query) {
                    let teamInfoItem = TeamInfo(teamName: teamInfos[teamName],
                                                teamImagePath: teamInfos[teamImagePath])
                    
                    return teamInfoItem
                }
            }
        } catch {
            print("Fetch Error : \(error)")
        }
        
        return TeamInfo(teamName: "", teamImagePath: "")
    }
}
