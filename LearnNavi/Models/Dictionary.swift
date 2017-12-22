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
        initVersion()
    }
    
    static func initizalizeIfMissing(_ fileURL: URL) {
        if(!FileManager.default.fileExists(atPath: fileURL.path)) {
            initWithBundledDictionary(fileURL)
        }
    }
    
    static func openBundledDictionary() -> Dictionary {
        let bundledDictionaryUrl = Bundle.main.resourceURL!.appendingPathComponent(Config.sharedInstance.databaseFilename())
        return Dictionary(path: bundledDictionaryUrl)
    }
    
    static func openDictionary() -> Dictionary {
        let dictionaryFileUrl = Config.sharedInstance.databaseFileURL()
        initizalizeIfMissing(dictionaryFileUrl)
        return Dictionary(path: dictionaryFileUrl)
    }
    
    static func initWithBundledDictionary(_ destinationFileUrl: URL) {
        let bundledDictionaryUrl = Bundle.main.resourceURL!.appendingPathComponent(Config.sharedInstance.databaseFilename())
        do {
            try FileManager.default.copyItem(at: bundledDictionaryUrl, to: destinationFileUrl)
            print("Main Database initialized with bundled Database")
        } catch (let writeError) {
            print("Error creating a file \(destinationFileUrl) : \(writeError)")
        }
    }
    
    public func getEntries() -> [Entry] {
        return schema.entry.selectAll()
    }
    
    public func getSections() -> [Section] {
        return schema.entry.getSections()
    }
    
    func initVersion() {
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
    
    static func checkForUpdate(_ currentVersion: Int = 0, completion: ((_ updateAvailable: Bool) -> Void)? = nil) {
        //Create URL to the source file you want to download
        let fileURL = URL(string: Config.sharedInstance.versionURL())
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:fileURL!)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let versionData = data, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully retieved version. Status code: \(statusCode)")
                }
                
                if let stringData = String(data: versionData, encoding: String.Encoding.utf8) {
                    if let version = Int(stringData.trimmingCharacters(in: .whitespacesAndNewlines)) {
                        if( version > currentVersion ) {
                            print("New Version Availabled: \(version)")
                        } else {
                            print("Dictionary already up to date")
                        }
                        completion?( version > currentVersion)
                    }
                }
            } else {
                print("Error took place while retrieving version. Error description: %@", error?.localizedDescription as Any);
            }
        }
        task.resume()
    }
    
    static func downloadDictionary(_ completion: ((_ updateSuccessful: Bool) -> Void)? = nil) {
        let destinationFileUrl = Config.sharedInstance.databaseFileURL()
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: Config.sharedInstance.databaseURL())
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:fileURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    let dictionary = Dictionary(path: tempLocalUrl)
                    let version = dictionary.version!
                    print("New Version \(version)")
                    if(version > 0) {
                        // Version greater than 0 is just to make sure the dictionary isn't in a bad state, more complex integrety checking may be a good idea at some point
                        try FileManager.default.removeItem(at: destinationFileUrl)
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                        completion?(true)
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    completion?(false)
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
                completion?(false)
            }
        }
        task.resume()
        
    }

}

