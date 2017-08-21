//
//  SquadMainViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 7..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadMainViewController: UIViewController, CustomAlertShowing {
    
    var viewController: UIViewController {
        return self
    }
    
    // MARK: Properties
    
    var playerArray = [Player]()
    var playerRecord: PlayerRecord!
    
    var deleteRow: Int = 0
    var deleteIndexPath: IndexPath = IndexPath()
    var deletePlayer: Player = Player(name: "", backNumber: 0, position: "")
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        let teamInfo = TeamInfoDAO.shared.fetch()
        self.navigationItem.title = teamInfo?.teamName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playerArray = PlayerDAO.shared.selectAll()!
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    // MARK: Actions
    
    @IBAction func addButtonDidTap(_ sender: UIBarButtonItem) {
        guard let squadAddPlayerViewController = storyboard?.instantiateViewController(withIdentifier: "SquadAddPlayerViewController") else { return }
        present(squadAddPlayerViewController, animated: true, completion: nil)
    }
    @IBAction func editButtonDidTap(_ sender: UIBarButtonItem) {
        if isEditing {
            // UIViewController has editing property
            sender.title = "Edit"
            setEditing(false, animated: true)
        } else {
            sender.title = "Done"
            setEditing(true, animated: true)
        }
    }
}

// MARK: Delegate

extension SquadMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteIndex = indexPath.row
            let deletePlayer = playerArray[deleteIndex]

            let title = "\(deletePlayer.name) 선수 삭제"
            let message = "정말로 지우시겠습니까?"
            let ac = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(
                title: "Delete",
                style: .destructive,
                handler: { (action) -> Void in
                    self.playerArray.remove(at: deleteIndex)
                    PlayerDAO.shared.delete(id: deletePlayer.playerID)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(cancelAction)
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
            
            deleteRow = indexPath.row
            deleteIndexPath = indexPath
            deletePlayer = playerArray[deleteRow]
            
            showAlertTwoButton(
                title: "\(deletePlayer.name)",
                message: "선수 정보를 삭제하시겠습니까?",
                confirmAction: deletePlayer)
        }
    }
    
    func deletePlayer(action: UIAlertAction) {
        self.playerArray.remove(at: deleteRow)
        PlayerDAO.shared.delete(id: deletePlayer.playerID)
        tableView.deleteRows(at: [deleteIndexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        if tableView.isEditing {
            let squadEditPlayerViewController = storyboard?.instantiateViewController(
                withIdentifier: "SquadEditPlayerViewController") as? SquadEditPlayerViewController
            // Edit
            let selectedPlayer = playerArray[indexPath.row]
            squadEditPlayerViewController?.player = selectedPlayer
            present(squadEditPlayerViewController!, animated: true, completion: nil)
            

        } else {
            let squadPlayerRecordViewController = storyboard?.instantiateViewController(
                withIdentifier: "SquadPlayerRecordViewController") as? SquadPlayerRecordViewController
            let squadPlayerRecordPageViewController = storyboard?.instantiateViewController(
                withIdentifier: "SquadPlayerRecordPageViewController") as? SquadPlayerRecordPageViewController

            self.navigationController?.pushViewController(squadPlayerRecordViewController!, animated: true)
            let selectedPlayer = playerArray[currentRow]
            self.playerRecord = PlayerRecordDAO.shared.selectOnPlayer(id: selectedPlayer.playerID)
            
            squadPlayerRecordViewController?.player = selectedPlayer
            squadPlayerRecordViewController?.playerRecord = self.playerRecord
            
            squadPlayerRecordPageViewController?.player = selectedPlayer
            squadPlayerRecordPageViewController?.playerRecord = self.playerRecord
        }
    }
}
