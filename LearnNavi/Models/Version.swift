//
//  Version.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/6/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import SQLite

class VersionTable: SQLTable<Version> {
    
    typealias Model = Version
    
    let version = Expression<Int>("version")
    let date = Expression<String>("date")
    let dictionaryDate = Expression<String>("dictionaryDate")
    
    init(_ db: Connection){
        super.init(db, table: Table("version"))
    }
    
    func getVersion() throws -> Int! {
        return try db.scalar(table.select(version.max))
    }
    
}

struct Version: Codable {
    
    let version : Int
    let date : String
    let dictionaryDate : String
    
    
    enum CodingKeys: String, CodingKey {
        case version = "version"
        case date = "date"
        case dictionaryDate = "dictionaryDate"
    }

}

