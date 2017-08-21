//
//  Player.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 10..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import Foundation

class Player: NSObject {
    
    var playerID: Int64
    var name: String
    var backNumber: Int
    var position: String
    
    init(id: Int64 = 0, name: String, backNumber: Int, position: String) {
        self.playerID = id
        self.name = name
        self.backNumber = backNumber
        self.position = position
    }
}
