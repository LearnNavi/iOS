//
//  AboutViewController.swift
//  LearnNavi
//
//  Created by Zoe Snow on 9/29/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit

class AboutViewController: LNViewController {

    // MARK: - Outlets
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVersionString()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setVersionString() {
        let versionNumber = Config.sharedInstance.versionNumber
        let buildNumber = Config.sharedInstance.buildNumber
        let gitHash = Config.sharedInstance.gitHash
        
        versionLabel.text = String(format: "Version %@ (%@-%@)", versionNumber, gitHash, buildNumber)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
