//
//  TeamInfo.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import Foundation

class TeamInfo: NSObject {
    
    let teamName: String
    let teamImagePath: String
    
    init(teamName: String, teamImagePath: String = "") {
        self.teamName = teamName
        self.teamImagePath = teamImagePath
    }
}
