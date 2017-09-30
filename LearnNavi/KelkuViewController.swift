//
//  KelkuViewController.swift
//  LearnNavi
//
//  Created by Zoe Snow on 9/29/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit

class KelkuViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet var betaText: UILabel!
    
    
    // MARK: - Actions
    @IBAction func returnToKelku(_ seque: UIStoryboardSegue) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        betaText.text = "Version " + bundleVersionNumber() + " (" + bundleBuildNumber() + ")"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func bundleVersionNumber() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    func bundleBuildNumber() -> String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }

}

