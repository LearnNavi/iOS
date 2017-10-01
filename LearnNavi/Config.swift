//
//  Config.swift
//  LearnNavi
//
//  Created by Zoe Snow on 9/30/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import Foundation

final class Config {
    // Singleton instance
    static let sharedInstance = Config()
    
    var mainConfig: NSDictionary!
    var envConfig: NSDictionary?
    let buildNumber: String
    let versionNumber: String
    let gitHash: String
    
    private init() {
        // Take current configuration value from the `Info.plist`. `Config` is the name of the Info plist key (fig. 7).
        //`currentConfiguration` Can be `Debug`, `Staging`, or whatever you created in previous steps.
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "LNConfig")!
        
        // Loads `Config.plist` and stores it to dictionary. The configuration names are the keys of the `configs` dictionary.
        let path = Bundle.main.path(forResource: "LNConfig", ofType: "plist")!
        mainConfig = NSDictionary(contentsOfFile: path)!
        envConfig = mainConfig.object(forKey: currentConfiguration) as? NSDictionary
        
        // Initialize our constants
        versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        gitHash = Bundle.main.infoDictionary?["LNGitHash"] as! String
    }
    
    open func fetchConfigItem(forKey aKey: Any) -> Any? {
        if envConfig != nil {
            return envConfig!.object(forKey: aKey)
        } else {
            return mainConfig.object(forKey: aKey)
        }
    }
    
    open func buttonBackImage() -> String {
        return fetchConfigItem(forKey: "LNButtonBackImage") as! String
    }
    
    open func buttonImage() -> String {
        return fetchConfigItem(forKey: "LNButtonImage") as! String
    }
    
    open func buttonHighlightedImage() -> String {
        return fetchConfigItem(forKey: "LNButtonHighlightedImage") as! String
    }
    
    open func websiteURL() -> String {
        return fetchConfigItem(forKey: "LNWebsiteURL") as! String
    }
    
    open func dictionaryURL() -> String {
        return fetchConfigItem(forKey: "LNDictionaryURL") as! String
    }
    
    open func databaseFile() -> String {
        return fetchConfigItem(forKey: "LNDatabaseFile") as! String
    }
    
    open func databaseVersionFile() -> String {
        return fetchConfigItem(forKey: "LNDatabaseVersionFile") as! String
    }
    
    open func databaseServerURL() -> String {
        return fetchConfigItem(forKey: "LNDatabaseServerURL") as! String
    }
    
}
