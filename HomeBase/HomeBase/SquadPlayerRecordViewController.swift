//
//  SquadPlayerRecordViewController.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 15..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadPlayerRecordViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var backNumberLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var playerRecordNavegationIntem: UINavigationItem!
    
    var player: Player!
    var playerRecord: PlayerRecord!
    var squadPlayerRecordPageViewController: SquadPlayerRecordPageViewController? {
        didSet {
            squadPlayerRecordPageViewController?.positionDelegate = self
        }
    }

    // MARK: Actions
    
    @IBAction func clickEditButton(_ sender: UIBarButtonItem) {
        let squadEditPlayerViewController = self.storyboard?.instantiateViewController(
            withIdentifier: "SquadEditPlayerViewController") as! SquadEditPlayerViewController
        
        squadEditPlayerViewController.player = self.player
        
        present(squadEditPlayerViewController, animated: true, completion: nil)
    }
    
    // MAKR: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(SquadPlayerRecordViewController.didChangePageControlValue), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerRecordNavegationIntem.title = player.name
        backNumberLabel.text = "\(player.backNumber)"
        positionLabel.text = player.position
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let squadPlayerRecordPageViewController = segue.destination as? SquadPlayerRecordPageViewController {
            squadPlayerRecordPageViewController.positionDelegate = self
            squadPlayerRecordPageViewController.player = self.player
            squadPlayerRecordPageViewController.playerRecord = self.playerRecord
        }
    }
    
    func didChangePageControlValue() {
        squadPlayerRecordPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension SquadPlayerRecordViewController: SquadPlayerRecordPageViewControllerDelegate {

    func positionPageViewController(
        _ tutorialPageViewController: SquadPlayerRecordPageViewController,
        didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func positionPageViewController(
        _ tutorialPageViewController: SquadPlayerRecordPageViewController,
        didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
}
