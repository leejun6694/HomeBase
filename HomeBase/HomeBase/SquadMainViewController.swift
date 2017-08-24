//
//  SquadMainViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 7..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadMainViewController: UIViewController, CustomAlertShowing {
    
    // MARK: Properties
    
    fileprivate var playerArray = [Player]()
    fileprivate var playerRecord: PlayerRecord!
    
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
        tableView.separatorStyle = .none
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let teamInfo = TeamInfoDAO.shared.select()
        self.navigationItem.title = teamInfo?.teamName
        
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
        cell.positionLabel.text = player.position + " >"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteIndex = indexPath.row
            let deletePlayer = playerArray[deleteIndex]

            let title = "\(deletePlayer.name)"
            let message = "선수를 삭제하시겠습니까?"
            let ac = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(
                title: "삭제",
                style: .destructive,
                handler: { (action) -> Void in
                    self.playerArray.remove(at: deleteIndex)
                    PlayerDAO.shared.delete(id: deletePlayer.playerID)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(cancelAction)
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
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
    
    func tableView(
        _ tableView: UITableView,
        editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteIndex = indexPath.row
        let selectedPlayer = self.playerArray[deleteIndex]
        let delete = UITableViewRowAction(style: .destructive , title: " ✕ ") { (action, indexPath) in
            // delete item at indexPath
            let title = "\(selectedPlayer.name)"
            let ac = UIAlertController(
                title: title,
                message: "선수를 삭제하시겠습니까?",
                preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(
                title: "삭제",
                style: .destructive,
                handler: { (action) -> Void in
                    self.playerArray.remove(at: deleteIndex)
                    PlayerDAO.shared.delete(id: selectedPlayer.playerID)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            ac.addAction(cancelAction)
            self.present(ac, animated: true, completion: nil)
        }
        delete.backgroundColor = UIColor(red: 255.0/255.0, green: 60.0/255.0, blue: 50.0/255.0, alpha: 0.9)
       
        return [delete]
    }
}
