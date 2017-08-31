//
//  HeaderViewCell.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 17..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class HeaderViewCell: UITableViewCell {
    @IBOutlet var allButton: UIButton!
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
