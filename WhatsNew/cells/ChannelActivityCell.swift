//
//  ChannelActivityCell.swift
//  WhatsNew
//
//  Created by Candice Guitton on 05/07/2018.
//  Copyright © 2018 Candice Guitton. All rights reserved.
//

import UIKit

class ChannelActivityCell: UITableViewCell {

    @IBOutlet weak var ibDescriptionLabel: UILabel!
    @IBOutlet weak var ibTitleLabel: UILabel!
    @IBOutlet weak var ibImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
