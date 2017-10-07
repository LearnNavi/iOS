//
//  LocalizedWord.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/6/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import SQLite

class LocalizedWordTable: SQLTable<LocalizedWord> {
    
    typealias Model = LocalizedWord

    init(_ db: Connection){
        super.init(db, table: Table("localizedWords"))
    }
}

struct LocalizedWord: Codable {
    
    let id : Int
    let languageCode : String
    let localized : String
    let partOfSpeech : String
    let alpha : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case languageCode = "languageCode"
        case localized = "localized"
        case partOfSpeech = "partOfSpeech"
        case alpha = "alpha"
    }
}
