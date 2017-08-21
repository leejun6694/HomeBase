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
    
    private let tableName = "TeamInfo"
    typealias T = TeamInfo
    let teamInfo: Table

    let teamName = Expression<String>("teamName")
    
    private init() {
        teamInfo = Table(tableName)
        let statement = teamInfo.create(ifNotExists: true) { t in
            t.column(teamName)
        }
        let result = DBManager.shared.createTable(statement)
        switch result {
        case .ok:
            print("TeamInfo Table Created")
        case .error(_): break
        }
    }
    
    // MARK: Functions
    
    func insert(item: T) {
        let query = teamInfo.insert(teamName <- item.teamName)
        let result = DBManager.shared.insert(query)
        switch result {
        case .ok(_): break
        case .error(_): break
        }
    }
    
    func updateTeamName(updateTeamName: String) {
        let quary = teamInfo.update(self.teamName <- updateTeamName)
        let result = DBManager.shared.update(quary)
        switch result {
        case .ok(_): break
        case .error(_): break
        }
    }
    
    func fetch() -> T? {
        let resultSet = DBManager.shared.select(teamInfo)
        switch resultSet {
        case let .ok(rows):
            for teamInfos in Array(rows) {
                let teamInfoItem = TeamInfo(teamName: teamInfos[teamName])
                return teamInfoItem
            }
        case .error: break
        }
        return nil
    }
    
    
}
