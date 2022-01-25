//
//  DictionaryViewController.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/1/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var lemmaLabel: UILabel?
    @IBOutlet weak var ipaLabel: UILabel?
    @IBOutlet weak var partOfSpeechLabel: UILabel?
    @IBOutlet weak var definitionLabel: UILabel?
    
    var entry: Entry?
    
    // MARK: - Actions
    @IBAction func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Add a background view to the table view

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        //blurView.alpha = 0.8
        blurView.frame = imageView!.bounds
        
        imageView!.addSubview(blurView)
        //self.view?.addSubview(imageView!)
        
        if let entry = entry {
            lemmaLabel?.text = entry.navi
            ipaLabel?.text = "[ \(entry.ipa.utf8) ]"
            partOfSpeechLabel?.text = entry.fancyPartOfSpeech
            definitionLabel?.text = entry.definition
            navigationItem.title = entry.navi
            navigationItem.hidesBackButton = true
        }
        
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
