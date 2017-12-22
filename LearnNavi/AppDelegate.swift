//
//  AppDelegate.swift
//  LearnNavi
//
//  Created by Zoe Snow on 9/29/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //var dictionary : Dictionary!
    
    override init() {
        
        //dictionary = Dictionary.openDictionary()
        // Call parent init...
        super.init()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])
        let dictionary = Dictionary.openDictionary()
        let currentVersion = dictionary.version!
        print("Database version: \(currentVersion)")
        Dictionary.checkForUpdate(currentVersion) { ( updateAvailable ) in
            if (updateAvailable) {
                let alert = UIAlertController(title: "Dictionary Update", message:
                    "New updates are now available! Download them now?", preferredStyle: UIAlertControllerStyle.alert)
                let actionYes = UIAlertAction(title: "Yes", style: .default, handler: { action in
                    print("User wants updates!")
                    Dictionary.downloadDictionary() { ( updateSuccessful ) in
                        if( updateSuccessful ) {
                            // Show success
                            let alertSuccess = UIAlertController(title: "Dictionary Updated", message: "The dictionary was successfully updated!", preferredStyle: .alert)
                            let actionDismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                            alertSuccess.addAction(actionDismiss)
                            
                            DispatchQueue.main.async {
                                self.window?.rootViewController?.present(alertSuccess, animated: true, completion: nil)
                            }
                        } else {
                            // Show failure
                            let alertFailure = UIAlertController(title: "Update Failed", message: "An error occurred while updating the dictionary!", preferredStyle: .alert)
                            let actionDismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                            alertFailure.addAction(actionDismiss)
                            
                            DispatchQueue.main.async {
                                self.window?.rootViewController?.present(alertFailure, animated: true, completion: nil)
                            }
                        }
                    }
                })
                
                let actionCancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
                    print("User cancelled update")
                })
                
                alert.addAction(actionYes)
                alert.addAction(actionCancel)
                
                DispatchQueue.main.async {
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

