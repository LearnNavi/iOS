//
//  Changelog.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/6/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import SQLite

class ChangelogTable: SQLTable<Changelog> {
    
    typealias Model = Changelog
    
    init(_ db: Connection){
        super.init(db, table: Table("changelog"))
    }
}

struct Changelog: Codable {
    
    let id : Int
    let description : String
    let version : Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case description = "description"
        case version = "version"
    }
    
}
