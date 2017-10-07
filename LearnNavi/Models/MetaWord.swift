//
//  MetaWord.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/6/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import SQLite

class MetaWordTable: SQLTable<MetaWord> {
    typealias Model = MetaWord
    
    init(_ db: Connection){
        super.init(db, table: Table("metaWords"))
    }
}

struct MetaWord: Codable {
    
    let id : Int
    let navi : String
    let naviNoSpecials : String
    let ipa : String
    let infixes : String
    let partOfSpeech : String
    let alpha : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case navi = "navi"
        case naviNoSpecials = "navi_no_specials"
        case ipa = "ipa"
        case infixes = "infixes"
        case partOfSpeech = "partOfSpeech"
        case alpha = "alpha"
    }
    
}
