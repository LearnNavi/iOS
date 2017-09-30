//
//  ResourcesViewController.swift
//  LearnNavi
//
//  Created by Zoe Snow on 9/29/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController {

    // MARK: - Actions
    @IBAction func returnToResources(_ seque: UIStoryboardSegue) {
        
    }
    
    @IBAction func openLearnNaviWebSite(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://www.learnnavi.org")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: "https://www.learnnavi.org")!)
            // Fallback on earlier versions
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
