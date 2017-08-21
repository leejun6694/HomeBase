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
    case ok(Int64)
    case error
}

enum ResultSet {
    case ok(AnySequence<Row>)
    case error
}

enum ArithmeticResult {
    case ok(Int)
    case error
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
        } catch {
            print(error)
            return .error(error)
        }
    }
    
    @discardableResult func insert(_ query: Insert) -> RowResult {
        do {
            if let lastInsertRowid = try self.db?.run(query) {
                return .ok(lastInsertRowid)
            }
            return .error
        } catch {
            print("Error: \(error)")
            return .error
        }
    }
    
    @discardableResult func update(_ query: Update) -> RowResult {
        do {
            if let changes = try self.db?.run(query) {
                return .ok(Int64(changes))
            }
            return .error
        } catch {
            print("Error: \(error)")
            return .error
        }
    }
    
    @discardableResult func delete(_ query: Delete) -> RowResult {
        do {
            if let changes = try self.db?.run(query) {
                return .ok(Int64(changes))
            }
            return .error
        } catch {
            print("ERROR: \(error)")
            return .error
        }
    }
    
    func select(_ query: QueryType) -> ResultSet {
        do {
            if let query = try self.db?.prepare(query) {
                return .ok(query)
            }
            return .error
        } catch {
            print("ERROR: \(error)")
            return .error
        }
    }
    
    func aggregate<V : Value>(_ query: ScalarQuery<V>) -> ArithmeticResult {
        do {
            if let value = try self.db?.scalar(query) as? Int {
                return .ok(value)
            }
            return .error
        } catch {
            print("Error: \(error)")
            return .error
        }
    }
}
