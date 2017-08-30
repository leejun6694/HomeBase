//
//  TeamRecord.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import Foundation

class TeamRecord: NSObject {
    
    var win: Int
    var draw: Int
    var lose: Int
    
    init(win: Int = 0, draw: Int = 0, lose: Int = 0) {
        self.win = win
        self.draw = draw
        self.lose = lose
    }
}
