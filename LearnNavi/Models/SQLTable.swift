//
//  SQLTable.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/6/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import Foundation
import SQLite

class SQLTable<Model : Codable> {

    let db: Connection
    var table: Table
    
    init(_ db: Connection, table: Table) {
        self.db = db
        self.table = table
    }
    
    public func selectAll() -> [Model] {
        do {
            let items: [Model] = try db.prepare(table).map { row in
                return try row.decode()
            }
            return items
            
        } catch {
            return []
        }
    }
    
    public func select(_ whereClause: Expression<Bool>) -> [Model] {
        do {
            let items: [Model] = try db.prepare(table.where(whereClause)).map { row in
                return try row.decode()
            }
            return items
            
        } catch {
            return []
        }
    }
    
}
