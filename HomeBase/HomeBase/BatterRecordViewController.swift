//
//  BatterRecordViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 13..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class BatterRecordViewController: UIViewController {
    
    @IBAction func clickBackgroundView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func clickOkButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
}
