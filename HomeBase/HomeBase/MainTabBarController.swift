//
//  MainTabBarController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 8..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var first: Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if first == false {
            first = true
            performSegue(withIdentifier: "segueTabToStart", sender: self)
        }
    }
}
