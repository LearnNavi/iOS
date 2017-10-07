//
//  Dictionary.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/1/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import Foundation
import SQLite

class Dictionary {

    let documentsUrl: URL
    let dbUrl: URL
    
    var db: Connection!
    var schema: Schema!
    var version: Int!
    
    init(path: URL) {
        
        documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        dbUrl = path
        openDatabaseConnection()
        getVersion()
    }
    
    public func fetchEntries() -> [Entry] {
        return schema.entry.selectAll()
    }
    
    func getVersion() {
        do {
            version = try schema.version.getVersion()
        } catch {
            print("Could not fetch version from database...")
        }
        
    }
    
    func openDatabaseConnection() {
        guard db == nil else {
            // Database already open...
            return
        }
        
        do {
            db = try Connection(dbUrl.path, readonly: true)
            schema = Schema(db)
        } catch {
            db = nil
            print("Error opening connection to DB: \(dbUrl.path)")
        }
    }
}

