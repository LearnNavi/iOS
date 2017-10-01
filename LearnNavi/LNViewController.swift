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
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://www.learnnavi.org")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: "https://www.learnnavi.org")!)
            // Fallback on earlier versions
        }
    }
    
    @IBAction func openDictionaryPDF(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "https://eanaeltu.learnnavi.org/dicts/NaviDictionary.pdf")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: "https://eanaeltu.learnnavi.org/dicts/NaviDictionary.pdf")!)
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
        if backButton != nil {
            backButton!.setBackgroundImage(UIImage.init(named: "Button_Purple"), for: .normal)
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
