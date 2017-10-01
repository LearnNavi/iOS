//
//  Dictionary.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/1/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import Foundation
import SQLite

final class Dictionary {
    // Singleton instance
    static let sharedInstance = Dictionary()

    var databaseFile: String
    var versionFile: String
    var serverURL: String
    
    private init() {
        databaseFile = Config.sharedInstance.databaseFile()
        versionFile = Config.sharedInstance.databaseVersionFile()
        serverURL = Config.sharedInstance.databaseServerURL()
        
    }
}

