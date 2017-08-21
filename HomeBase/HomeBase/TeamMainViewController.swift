//
//  TeamMainViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 7..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//


import UIKit

class TeamMainViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var teamNameLabel: UILabel!
    @IBOutlet var teamMainTableView: UITableView!
    @IBOutlet var matchResultsTextField: UILabel!
    @IBOutlet var teamBattingAverageTextField: UILabel!
    @IBOutlet var teamERATextField: UILabel!
    
    var teamInfo: TeamInfo?
    var schedule: [TeamSchedule] = [TeamSchedule]()
    var player: PlayerDAO?
    
    var playerBattingAverage = [Int64:Double]()
    var playerPitchingAverage = [Int64:Double]()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    let batterNumberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 3
        nf.maximumFractionDigits = 3
        
        return nf
    }()
    
    let pitcherNumberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        
        return nf
    }()
    
    // MARK: Functions
    
    fileprivate func fetchImage() {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        let url: URL = documentDirectory.appendingPathComponent("TeamImage")
        
        if let data = try? Data(contentsOf: url, options: .alwaysMapped) {
            self.mainImageView.image = UIImage(data: data)
            self.mainImageView.alpha = 0.5
        }
    }
    
    fileprivate func calculateMatchRecords() {
        let matchRecord = TeamScheduleDAO.shared.fetchMatchResult()
        
        matchResultsTextField.text = "\(matchRecord.win)승 \(matchRecord.draw)무 \(matchRecord.lose)패"
    }
    
    fileprivate func calculateTeamBattingAverage() {
        let teamHit = PlayerRecordDAO.shared.selectHits()
        let teamOut = PlayerRecordDAO.shared.selectOuts()
        
        
        if (teamHit + teamOut) == 0.0 {
            teamBattingAverageTextField.text = "0.000"
        }
        else {
            let teamBattingAverage: Double = teamHit / (teamHit + teamOut)
            teamBattingAverageTextField.text = "\(batterNumberFormatter.string(from: NSNumber(value: teamBattingAverage))!)"
        }
    }
    
    fileprivate func calculateTeamERA() {
        let teamER = PlayerRecordDAO.shared.selectER()
        let teamInning = PlayerRecordDAO.shared.selectInning()
        
        if teamInning == 0.0 {
            teamERATextField.text = "0.00"
        }
        else {
            let teamERA = teamER * 9 / teamInning
            teamERATextField.text = "\(pitcherNumberFormatter.string(from: NSNumber(value: teamERA))!)"
        }
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamMainTableView.sectionFooterHeight = 0
        self.automaticallyAdjustsScrollViewInsets = false
        
        teamMainTableView.register(UINib(nibName: "HeaderViewCell", bundle: nil), forCellReuseIdentifier: "HeaderViewCell")
        teamMainTableView.register(UINib(nibName: "FooterViewCell", bundle: nil), forCellReuseIdentifier: "FooterViewCell")
        
        teamMainTableView.dataSource = self
        teamMainTableView.delegate = self
        teamMainTableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        teamInfo = TeamInfoDAO.shared.fetch()
        
        fetchImage()
        
        teamNameLabel.text = teamInfo?.teamName
        
        schedule = TeamScheduleDAO.shared.findAllColumn()!
        
        calculateMatchRecords()
        calculateTeamBattingAverage()
        calculateTeamERA()
        
        player = PlayerDAO.shared
        playerBattingAverage = PlayerRecordDAO.shared.selectPlayerBatting()!
        playerPitchingAverage = PlayerRecordDAO.shared.selectPlayerPitching()!
        teamMainTableView.reloadData()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: Actions
    
    func allScheduleButtonDidTap(_ btControl: UIButton) {
        let allScheduleViewController = storyboard?.instantiateViewController(
            withIdentifier: "AllScheduleViewController")
        self.navigationController?.pushViewController(allScheduleViewController!, animated: true)
    }
    
    func addScheduleButtonDidTap(_ btControl: UIButton) {
        guard let addScheduleViewController = storyboard?.instantiateViewController(withIdentifier: "AddScheduleViewController") else { return }
        
        present(addScheduleViewController, animated: true, completion: nil)
    }
    
    @IBAction func clickSettingButton(_ sender: UIButton) {
        let teamSettingViewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamSettingViewController") as! TeamSettingViewController
        
        present(teamSettingViewController, animated: true, completion: nil)
    }
}

// MARK: TableViewDataSource

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
            if playerBattingAverage.count <= 3 {
                numberOfRows = playerBattingAverage.count
            }
            else {
                numberOfRows = 3
            }
        case 2:
            if playerPitchingAverage.count <= 3 {
                numberOfRows = playerPitchingAverage.count
            }
            else {
                numberOfRows = 3
            }
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
                scheduleCell.matchOpponentLabel.text = "vs " + scheduleAtRow.matchOpponent
                return scheduleCell
            }
        } else if currentSection == 1 {
            print(playerBattingAverage)
            let recordCell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! TeamRecordTableViewCell
            
            let sortedBattingAverage = playerBattingAverage.sorted(by: { $0.1 > $1.1 })
            
            if currentRow < sortedBattingAverage.count {
                recordCell.playerNameLabel.text = PlayerDAO.shared.findName(findPlayerID: Array(sortedBattingAverage)[currentRow].key)
                recordCell.recordLabel.text = "\(batterNumberFormatter.string(from: NSNumber(value: Array(sortedBattingAverage)[currentRow].value))!)"
            }
            
            return recordCell
        } else {
            let recordCell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! TeamRecordTableViewCell
            
            let sortedPitchingAverage = playerPitchingAverage.sorted(by: { $0.1 < $1.1 })
            
            if currentRow < sortedPitchingAverage.count {
                recordCell.playerNameLabel.text = PlayerDAO.shared.findName(findPlayerID: Array(sortedPitchingAverage)[currentRow].key)
                recordCell.recordLabel.text = "\(pitcherNumberFormatter.string(from: NSNumber(value: Array(sortedPitchingAverage)[currentRow].value))!)"
            }
            
            return recordCell
        }
    }
}

// MARK: TableViewDelegate

extension TeamMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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

