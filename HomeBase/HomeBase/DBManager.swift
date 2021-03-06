//
//  DBManager.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 9..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import Foundation
import SQLite

enum TableResult {
    case ok
    case error(Error)
}

enum RowResult {
    case ok(Int64?)
    case error(Error)
}

enum ResultSet {
    case ok(AnySequence<Row>?)
    case error(Error)
}

enum ArithmeticResult {
    case ok(Int?)
    case error(Error)
}

class DBManager: NSObject {
    
    static let shared: DBManager = DBManager()
    
    let db: Connection? = {
        guard let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask, true).first else {
                return nil
        }
        do {
            let db = try Connection("\(path)/db.sqlite3")
            print(path)
            return db
        } catch {
            NSLog("Database Connection Error")
            return nil
        }
    }()
    
    func createTable(_ statement: String) -> TableResult {
        do {
            try self.db?.run(statement)
            return .ok
        } catch let error {
            return .error(error)
        }
    }
    
    @discardableResult func insert(_ query: Insert) -> RowResult {
        do {
            if let lastInsertRowid = try self.db?.run(query) {
                return .ok(lastInsertRowid)
            }
        } catch let error {
            print("Insert Error: \(error)")
            return .error(error)
        }
        return .ok(nil)
    }
    
    @discardableResult func update(_ query: Update) -> RowResult {
        do {
            if let changes = try self.db?.run(query) {
                return .ok(Int64(changes))
            }
            
        } catch let error {
            print("Update Error: \(error)")
            return .error(error)
        }
        return .ok(nil)
    }
    
    @discardableResult func delete(_ query: Delete) -> RowResult {
        do {
            if let changes = try self.db?.run(query) {
                return .ok(Int64(changes))
            }
        } catch let error {
            print("Delete Error: \(error)")
            return .error(error)
        }
        return .ok(nil)
    }
    
   func select(_ query: QueryType) -> ResultSet {
        do {
            if let query = try self.db?.prepare(query) {
                return .ok(query)
            }
        } catch let error {
            print("Select ERROR: \(error)")
            return .error(error)
        }
        return .ok(nil)
    
    }
    
    func aggregate<V : Value>(_ query: ScalarQuery<V>) -> ArithmeticResult {
        do {
            if let value = try self.db?.scalar(query) as? Int {
                return .ok(value)
            }
            
        } catch let error {
            print("Aggregate Error: \(error)")
            return .error(error)
        }
        return .ok(nil)
    }
}
