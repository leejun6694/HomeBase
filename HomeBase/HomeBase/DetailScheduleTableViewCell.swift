//
//  DetailScheduleTableViewCell.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 9..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class DetailScheduleTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet var playerLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func clickAddButton(_ sender: UIButton) {
        
    }
    
    // MARK: Functions
    
    func updateLabelsFont() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        playerLabel.font = bodyFont
    }
}
