//
//  EntryTableViewCell.swift
//  LearnNavi
//
//  Created by Zoe Snow on 10/7/17.
//  Copyright © 2017 Learn Na'vi. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var lemmaLabel: UILabel!
    @IBOutlet weak var ipaLabel: UILabel!
    @IBOutlet weak var posLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
