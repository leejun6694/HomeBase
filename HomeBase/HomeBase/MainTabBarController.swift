//
//  MainTabBarController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 8..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let teamInfo = TeamInfoDAO.shared.fetch()
        print(teamInfo.teamImagePath)
        if teamInfo.teamName == "" {
            performSegue(withIdentifier: "segueTabToStart", sender: self)
        }
    }
}
