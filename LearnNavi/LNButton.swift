//
//  LNButton.swift
//  LearnNavi
//
//  Created by Zoe Snow on 9/30/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit

class LNButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        // set other operations after super.init, if required
        let buttonImage = Config.sharedInstance.buttonImage()
        let buttonHighlightedImage = Config.sharedInstance.buttonHighlightedImage()
        self.setBackgroundImage(UIImage.init(named: buttonImage), for: .normal)
        self.setBackgroundImage(UIImage.init(named: buttonHighlightedImage), for: .selected)
        self.setBackgroundImage(UIImage.init(named: buttonHighlightedImage), for: .highlighted)
        //self.contentEdgeInsets = UIEdgeInsets.init(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
        //self.titleLabel!.font = UIFont.init(name: "Toruk SC", size: 30.0)
        //self.setTitleColor(UIColor.white, for: [])
        //self.titleLabel!.highlightedTextColor = UIColor.white
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
