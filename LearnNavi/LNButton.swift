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
        self.setBackgroundImage(UIImage.init(named: "Button_Gray"), for: .normal)
        self.setBackgroundImage(UIImage.init(named: "Button_Orange"), for: .selected)
        self.setBackgroundImage(UIImage.init(named: "Button_Orange"), for: .highlighted)
        self.contentEdgeInsets = UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0)
        self.titleLabel!.font = UIFont.init(name: "Papyrus", size: 32.0)
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
