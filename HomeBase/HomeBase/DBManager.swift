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
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
                return nil
        }
        
        do {
            let db = try Connection("\(path)/db.sqlite3")
            return db
        } catch {
            NSLog("Database Connection Error")
            return nil
        }
    }()
}
