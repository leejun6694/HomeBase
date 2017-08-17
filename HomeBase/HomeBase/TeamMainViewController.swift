//
//  TeamMainViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 7..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//


import UIKit

class TeamMainViewController: UIViewController {
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var teamNameLabel: UILabel!
    @IBOutlet var teamMainTableView: UITableView!
    
    var teamInfo: TeamInfo?
    var schedule: [TeamSchedule] = [TeamSchedule]()
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamInfo = TeamInfoDAO.shared.fetch()
        guard let teamImage = teamInfo?.teamImagePath else {
            return
        }
        print(" image path is \(teamImage)")
        let url = URL(fileURLWithPath: teamImage)
        print(" URL is \(url)")
        do {
            let data = try Data(contentsOf: url, options: .alwaysMapped)
            mainImageView.image = UIImage(data: data)
        } catch {
            print(error)
        }
        teamNameLabel.text = teamInfo?.teamName
        teamMainTableView.sectionFooterHeight = 0
        self.automaticallyAdjustsScrollViewInsets = false
        teamMainTableView.register(UINib(nibName: "HeaderViewCell", bundle: nil), forCellReuseIdentifier: "HeaderViewCell")
        teamMainTableView.register(UINib(nibName: "FooterViewCell", bundle: nil), forCellReuseIdentifier: "FooterViewCell")
        teamMainTableView.dataSource = self
        teamMainTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        schedule = TeamScheduleDAO.shared.findAllColumn()
        teamMainTableView.reloadData()
        
    }
    
    func allScheduleButtonDidTap(_ btControl: UIButton) {
        let allScheduleViewController = storyboard?.instantiateViewController(
            withIdentifier: "AllScheduleViewController")
        self.navigationController?.pushViewController(allScheduleViewController!, animated: false)
    }
    
    func addScheduleButtonDidTap(_ btControl: UIButton) {
        guard let addScheduleViewController = storyboard?.instantiateViewController(withIdentifier: "AddScheduleViewController") else { return }
        
        present(addScheduleViewController, animated: true, completion: nil)
    }
    
}

extension TeamMainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        switch section {
        case 0:
            if schedule.count < 4 {
                numberOfRows = schedule.count + 1
            } else {
                numberOfRows = 5
            }
            
        case 1:
            numberOfRows = 3
        case 2:
            numberOfRows = 3
        default:
            break
        }
        return numberOfRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = indexPath.section
        let currentRow = indexPath.row
        if currentSection == 0 {
            if (schedule.count < 4 && currentRow == schedule.count) || currentRow == 4{
                print("-----------------------")
                let footerCell = tableView.dequeueReusableCell(withIdentifier: "FooterViewCell") as! FooterViewCell
                footerCell.addScheduleButton.addTarget(
                    self,
                    action: #selector(TeamMainViewController.addScheduleButtonDidTap(_:)),
                    for: .touchUpInside)
                return footerCell
            } else {
                let scheduleCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! TeamScheduleTableViewCell
                let scheduleAtRow = schedule[indexPath.row]
                scheduleCell.matchDateLabel.text = dateFormatter.string(from: scheduleAtRow.matchDate)
                scheduleCell.matchOpponentLabel.text = scheduleAtRow.matchOpponent
                return scheduleCell
            }
        } else {
            let recordCell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! TeamRecordTableViewCell
            return recordCell
        }
    }
}

extension TeamMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("viewForHeaderInSection")
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderViewCell") as! HeaderViewCell
        switch section {
        case 0:
            headerCell.titleLabel.text = "경기 일정"
            headerCell.allButton.addTarget(
                self,
                action: #selector(TeamMainViewController.allScheduleButtonDidTap(_:)),
                for: .touchUpInside)
        case 1:
            headerCell.titleLabel.text = "타율 Top 3"
            headerCell.allButton.alpha = 0
        case 2:
            headerCell.titleLabel.text = "방어율 Top 3"
            headerCell.allButton.alpha = 0
        default:
            break
            
        }
        return headerCell
    }
}

