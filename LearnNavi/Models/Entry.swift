//
//  Entry.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/6/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import SQLite

class EntryTable: SQLTable<Entry> {
    typealias Model = Entry
    
    init(_ db: Connection){
        super.init(db, table: Table("entries").order(Expression<String>("navi_no_specials").lowercaseString))
    }
    
    func getSections() -> [Section] {
        do {
            let alphaColumn = Expression<String>("alpha")
            let sections: [Section] = try db.prepare("SELECT alpha FROM entries GROUP BY alpha").map { row in
                let rawAlpha = row[0] as! String
                let alpha = convertStringFromDatabase(rawAlpha)
                let entries = select(alphaColumn == rawAlpha)
                
                return Section(alpha: alpha, entries: entries)
            }
            
            return sections
            
        } catch {
            print("Could not fetch sections...")
            return []
        }
    }
    
    func convertStringFromDatabase(_ databaseString: String) -> String {
        return databaseString.replacingOccurrences(of: "b", with: "ä")
            .replacingOccurrences(of: "B", with: "Ä")
            .replacingOccurrences(of: "j", with: "ì")
            .replacingOccurrences(of: "J", with: "Ì")
    }
}

struct Entry: Codable {
    
    let id : Int
    let navi : String
    let naviNoSpecials : String
    let ipa : String
    let infixes : String
    let definition : String
    let partOfSpeech : String
    let fancyPartOfSpeech : String
    let alpha : String
    let beta : String
    let version : Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case navi = "navi"
        case naviNoSpecials = "navi_no_specials"
        case ipa = "ipa"
        case infixes = "infixes"
        case definition = "definition"
        case partOfSpeech = "partOfSpeech"
        case fancyPartOfSpeech = "fancyPartOfSpeech"
        case alpha = "alpha"
        case beta = "beta"
        case version = "version"
    }
    
}
