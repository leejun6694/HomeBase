//
//  AllScheduleTableViewCell.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 9..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class AllScheduleTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet var matchDateLabel: UILabel!
    @IBOutlet var matchOpponentLabel: UILabel!
    
    // MARK: Functions
    
    func updateLabelsFont() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        matchDateLabel.font = bodyFont
        matchOpponentLabel.font = bodyFont
    }
}
