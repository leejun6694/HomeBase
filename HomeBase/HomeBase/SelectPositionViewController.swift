//
//  SelectPositionViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 13..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SelectPositionViewController: UIViewController {
    
    // MARK: Properties
    
    var row: Int!
    var playerID: Int64!
    var scheduleID: Int64!
    
    // MARK: Actions
    
    @IBAction func clickBackgroundView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func clickBatterButton(_ sender: UIButton) {
        let batterRecordViewController = self.storyboard!.instantiateViewController(
            withIdentifier: "BatterRecordViewController") as! BatterRecordViewController
        
        batterRecordViewController.row = self.row
        batterRecordViewController.playerID = self.playerID
        batterRecordViewController.scheduleID = self.scheduleID
    
        batterRecordViewController.modalPresentationStyle = .currentContext
        present(batterRecordViewController, animated: false, completion: nil)
    }
    
    @IBAction func clickPitcherButton(_ sender: UIButton) {
        let pitcherRecordViewController = self.storyboard!.instantiateViewController(
            withIdentifier: "PitcherRecordViewController") as! PitcherRecordViewController
        
        pitcherRecordViewController.row = self.row
        pitcherRecordViewController.playerID = self.playerID
        pitcherRecordViewController.scheduleID = self.scheduleID
        
        pitcherRecordViewController.modalPresentationStyle = .currentContext
        present(pitcherRecordViewController, animated: false, completion: nil)
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
}
