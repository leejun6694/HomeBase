//
//  DBManager.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 9..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import Foundation
import SQLite

class DBManager: NSObject {
    
    static let shared: DBManager = DBManager()
    
    let db: Connection? = {
        guard let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first else {
                return nil
        }
        let db = try? Connection("\(path)/db.sqlite3")
        print("Make DB")
        return db
    }()
    
}
