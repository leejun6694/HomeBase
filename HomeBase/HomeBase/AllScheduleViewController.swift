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
    var scheduleArray = [TeamSchedule]()
    
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
        scheduleArray = TeamScheduleDAO.shared.findAllColumn()
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.automaticallyAdjustsScrollViewInsets = false
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
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
                detailViewController.scheduleItem = scheduleArray[row]
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
        let scheduleCount = TeamScheduleDAO.shared.countAll()
        
        return scheduleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllScheduleTableViewCell", for: indexPath) as! AllScheduleTableViewCell
        
        cell.matchDateLabel.text = dateFormatter.string(from: scheduleArray[indexPath.row].matchDate)
        cell.matchOpponentLabel.text = scheduleArray[indexPath.row].matchOpponent
        
        return cell
    }
}
