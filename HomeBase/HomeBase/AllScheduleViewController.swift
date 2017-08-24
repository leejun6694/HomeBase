//
//  AllScheduleViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 8..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit
import SQLite

class AllScheduleViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var scheduleTableView: UITableView!
    
    /// Array of all team schedules
    fileprivate var scheduleArray = [TeamSchedule]()
    
    fileprivate let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.automaticallyAdjustsScrollViewInsets = false
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scheduleArray = TeamScheduleDAO.shared.selectAllColumn()!
        scheduleTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == .segueScheduleToDetail {
            if let row = self.scheduleTableView.indexPathForSelectedRow?.row {
                
                let detailViewController = segue.destination as! DetailScheduleViewController
                detailViewController.scheduleItem = scheduleArray[row]
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction private func addButtonDidTapped(_ sender: UIBarButtonItem) {
        guard let addScheduleViewController = storyboard?.instantiateViewController(
            withIdentifier: .addScheduleViewController) else { return }
        
        present(addScheduleViewController, animated: true, completion: nil)
    }
}

// MARK: TableView Delegate, DataSource

extension AllScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let scheduleCount = TeamScheduleDAO.shared.countAll()
        
        return scheduleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: .allScheduleTableViewCell, for: indexPath) as! AllScheduleTableViewCell
        
        cell.matchDateLabel.text = dateFormatter.string(from: scheduleArray[indexPath.row].matchDate)
        cell.matchOpponentLabel.text = "vs " + scheduleArray[indexPath.row].matchOpponent
        
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteIndex = indexPath.row
        let selectedSchedule = self.scheduleArray[deleteIndex]
        let delete = UITableViewRowAction(style: .destructive , title: "✕\n Delete") { (action, indexPath) in
            // delete item at indexPath
            let ac = UIAlertController(
                title: .deleteActionTitle,
                message: .alertMessageOfDeleteSchedule,
                preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(
                title: .cancelActionTitle,
                style: .cancel,
                handler: nil)
            let deleteAction = UIAlertAction(
                title: .deleteActionTitle,
                style: .destructive,
                handler: { (action) -> Void in
                    self.scheduleArray.remove(at: deleteIndex)
                    TeamScheduleDAO.shared.delete(id: selectedSchedule.scheduleID)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            ac.addAction(cancelAction)
            self.present(ac, animated: true, completion: nil)
        }

        let editScheduleViewController = storyboard?.instantiateViewController(
            withIdentifier: .editScheduleViewController) as? EditScheduleViewController
        let edit = UITableViewRowAction(style: .normal, title: "✎\n Edit") { (action, indexPath) in
            let selectedSchedule = self.scheduleArray[indexPath.row]
            editScheduleViewController?.preSchedule = selectedSchedule
            self.present(editScheduleViewController!, animated: true, completion: nil)
        }
        edit.backgroundColor = UIColor(red: 242/255, green: 150/255, blue: 97/255, alpha: 1)
    
        return [delete, edit]
    }
}
