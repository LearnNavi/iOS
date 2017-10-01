//
//  LNViewController.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/1/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit

class LNViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var backButton: LNButton?
    
    // MARK: - Actions
    @IBAction func unwindSeque(_ seque: UIStoryboardSegue) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    @IBAction func openLearnNaviWebSite(_ sender: UIButton) {
        let url = Config.sharedInstance.websiteURL()
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: url)!)
            // Fallback on earlier versions
        }
    }
    
    @IBAction func openDictionaryPDF(_ sender: UIButton) {
        let url = Config.sharedInstance.dictionaryURL()
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: url)!)
            // Fallback on earlier versions
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the back button
        configureBackButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureBackButton() {
        let buttonImage = Config.sharedInstance.buttonBackImage()
        if backButton != nil {
            backButton!.setBackgroundImage(UIImage.init(named: buttonImage), for: .normal)
        }
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
