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
    var matchDateStore = [String]()
    var matchPlaceStore = [String]()
    var matchOpponentStore = [String]()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    // MARK: Actions
    
    @IBAction func clickAddButton(_ sender: UIBarButtonItem) {
        guard let addScheduleViewController = storyboard?.instantiateViewController(withIdentifier: "AddScheduleViewController") else { return }
        
        present(addScheduleViewController, animated: true, completion: nil)
    }
    
    // 매번 데이터를 불러올때 비웠다가 다시 하나씩 채워야함
    // 좀 더 깔끔하게 만들어보자
    private func loadData() {
        matchDateStore = []
        matchPlaceStore = []
        matchOpponentStore = []
        
        do {
            for schedule in try DBManager.shared.db!.prepare(TeamScheduleDAO.shared.teamSchedule.select(TeamScheduleDAO.shared.matchDate, TeamScheduleDAO.shared.matchPlace, TeamScheduleDAO.shared.matchOpponent).order(TeamScheduleDAO.shared.matchDate.desc)) {
                matchDateStore.append(dateFormatter.string(from: schedule[TeamScheduleDAO.shared.matchDate]))
                matchPlaceStore.append(schedule[TeamScheduleDAO.shared.matchPlace])
                matchOpponentStore.append(schedule[TeamScheduleDAO.shared.matchOpponent])
            }
        } catch {
            NSLog("No Database!")
        }
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.automaticallyAdjustsScrollViewInsets = false
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
        let teamScheduleDAO = TeamScheduleDAO()
        teamScheduleDAO.createTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        scheduleTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueScheduleToDetail" {
            if let row = self.scheduleTableView.indexPathForSelectedRow?.row {
                
                let detailViewController = segue.destination as! DetailScheduleViewController
                detailViewController.matchDate = matchDateStore[row]
                detailViewController.matchPlace = matchPlaceStore[row]
                detailViewController.matchOpponent = matchOpponentStore[row]
            }
        }
    }
}

// MARK: TableView Delegate, DataSource

extension AllScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var scheduleCount: Int
        
        do {
            scheduleCount = try DBManager.shared.db?.scalar(TeamScheduleDAO.shared.teamSchedule.count) ?? 0
        } catch {
            scheduleCount = 0
        }
        
        return scheduleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllScheduleTableViewCell", for: indexPath) as! AllScheduleTableViewCell
        
        cell.matchDateLabel.text = matchDateStore[indexPath.row]
        cell.matchOpponentLabel.text = matchOpponentStore[indexPath.row]
        
        return cell
    }
}
