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
    
    let teamInfo: Table
    
    private init() {
        
        teamInfo = Table("TeamInfo")
        
        do {
            try DBManager.shared.db?.run(teamInfo.create(ifNotExists: true) {
                t in
                
                t.column(teamName)
            })
        } catch {
            print("Error : \(error)")
        }
    }
    
    // MARK: Functions
    
    func insert(insertTeamInfo: TeamInfo) {
        do {
            try DBManager.shared.db?.run(teamInfo.insert(
                teamName <- insertTeamInfo.teamName))
        } catch {
            print("Insert Error : \(error)")
        }
    }
    
    func fetch() -> TeamInfo {
        do {
            if let query = try DBManager.shared.db?.prepare(teamInfo) {
                for teamInfos in Array(query) {
                    let teamInfoItem = TeamInfo(teamName: teamInfos[teamName])
                    
                    return teamInfoItem
                }
            }
        } catch {
            print("Fetch Error : \(error)")
        }
        
        return TeamInfo(teamName: "")
    }
    
    func updateTeamName(updateTeamName: String) {
        do {
            try DBManager.shared.db?.run(teamInfo.update(self.teamName <- updateTeamName))
        } catch {
            print("Update Error : \(error)")
        }
    }
}
