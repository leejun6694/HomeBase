//
//  SelectPositionViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 13..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SelectPositionViewController: UIViewController {
    
    @IBAction func clickBackgroundView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func clickBatterButton(_ sender: UIButton) {
        let batterRecordViewController = self.storyboard!.instantiateViewController(withIdentifier: "BatterRecordViewController")
        batterRecordViewController.modalPresentationStyle = .currentContext
        
//        dismiss(animated: false, completion: nil)
        present(batterRecordViewController, animated: false, completion: nil)
    }
    
    @IBAction func clickPitcherButton(_ sender: UIButton) {
        let pitcherRecordViewController = self.storyboard!.instantiateViewController(withIdentifier: "PitcherRecordViewController")
        pitcherRecordViewController.modalPresentationStyle = .currentContext
        
        present(pitcherRecordViewController, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
}
