//
//  SquadMainViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 7..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadMainViewController: UIViewController {
    
    // MARK: Properties
    
    var playerArray = [Player]()
    var playerRecord: PlayerRecord!
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        let teamInfo = TeamInfoDAO.shared.fetch()
        self.navigationItem.title = teamInfo.teamName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playerArray = PlayerDAO.shared.selectAll()!
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSquadMainToPageControl" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let selectedPlayer = playerArray[row]
                let squadPlayerRecordViewController = segue.destination as! SquadPlayerRecordViewController
                self.playerRecord = PlayerRecordDAO.shared.selectOnPlayer(id: selectedPlayer.playerID)
                
                squadPlayerRecordViewController.player = selectedPlayer
                squadPlayerRecordViewController.playerRecord = self.playerRecord
                
                if let squadPlayerRecordPageViewController = segue.destination as? SquadPlayerRecordPageViewController {
                    //squadPlayerRecordPageViewController.positionDelegate = self
                    squadPlayerRecordPageViewController.player = selectedPlayer
                    squadPlayerRecordPageViewController.playerRecord = self.playerRecord
                }
                if let batterViewController = segue.destination as? BatterViewController {
                    batterViewController.record = playerRecord
                }
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func addButtonDidTap(_ sender: UIBarButtonItem) {
        guard let squadAddPlayerViewController = storyboard?.instantiateViewController(withIdentifier: "SquadAddPlayerViewController") else { return }
        present(squadAddPlayerViewController, animated: true, completion: nil)
    }
}

// MARK: Delegate

extension SquadMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SquadCell", for: indexPath) as! SquadPlayerTableViewCell
        
        let player = playerArray[indexPath.row]
        cell.playerNameLabel.text = player.name
        cell.playerBackNumberLabel.text = "\(player.backNumber)"
        cell.positionLabel.text = player.position
        return cell
    }
}
