//
//  DatabaseSchemaV1.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/5/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import Foundation
import SQLite

class Schema {
    
    let version : VersionTable
    let changelog : ChangelogTable
    let entry : EntryTable
    let localizedWord : LocalizedWordTable
    let metaWord : MetaWordTable
    
    init(_ db: Connection) {
        version = VersionTable(db)
        changelog = ChangelogTable(db)
        entry = EntryTable(db)
        localizedWord = LocalizedWordTable(db)
        metaWord = MetaWordTable(db)
    }
}
