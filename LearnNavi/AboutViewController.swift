//
//  AboutViewController.swift
//  LearnNavi
//
//  Created by Zoe Snow on 9/29/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var backButton: LNButton!
    @IBOutlet weak var aboutText: UITextView!
    @IBOutlet weak var aboutTextShadow: UITextView!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setBackgroundImage(UIImage.init(named: "Button_Gray"), for: .normal)
        versionLabel.text = "Version " + bundleVersionNumber() + " (" + bundleGitHash() + "-" + bundleBuildNumber() + ")"
        // Do any additional setup after loading the view.
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
    
    func bundleGitHash() -> String {
        return Bundle.main.infoDictionary?["GIT_HASH"] as! String
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
