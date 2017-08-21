//
//  DetailScheduleViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 9..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class DetailScheduleViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var matchDateLabel: UILabel!
    @IBOutlet var matchPlaceLabel: UILabel!
    @IBOutlet var resultView: UIView!
    @IBOutlet var homeScoreButton: UIButton!
    @IBOutlet var awayScoreButton: UIButton!
    @IBOutlet var matchTableView: UITableView!
    
    var playerArray = [Player]()
    var scheduleItem: TeamSchedule!
    let currentDate = Date()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    fileprivate lazy var beforeDateLabel: UILabel = {
        let beforeDateLabel = UILabel()
        beforeDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return beforeDateLabel
    }()
    
    // MARK: Actions
    
    @IBAction func clickHomeScoreButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "홈 팀 점수를 입력하세요",
                                                message: "",
                                                preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: configurationTextField(textField:))
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
            if let homeTextField = alertController.textFields?[0] {
                self.homeScoreButton.setTitle(homeTextField.text ?? "", for: .normal)
                
                TeamScheduleDAO.shared.updateHomeScore(
                    updateScheduleID: self.scheduleItem.scheduleID, Int(homeTextField.text!) ?? -1)
            }
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func clickAwayScoreButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "원정 팀 점수를 입력하세요",
                                                message: "",
                                                preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: configurationTextField(textField:))
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
            if let awayTextField = alertController.textFields?[0] {
                self.awayScoreButton.setTitle(awayTextField.text ?? "", for: .normal)
                
                TeamScheduleDAO.shared.updateAwayScore(
                    updateScheduleID: self.scheduleItem.scheduleID, Int(awayTextField.text!) ?? -1)
            }
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func configurationTextField(textField: UITextField) {
        textField.placeholder = ""
        textField.keyboardType = .numberPad
    }
    
    @objc fileprivate func clickPlayerResultButton(_ sender: UIButton) {
        
        let buttonRow = sender.tag
        
        let selectPositionViewController = self.storyboard!.instantiateViewController(
            withIdentifier: "SelectPositionViewController") as! SelectPositionViewController
        
        selectPositionViewController.row = buttonRow
        selectPositionViewController.playerID = self.playerArray[buttonRow].playerID
        selectPositionViewController.scheduleID = self.scheduleItem.scheduleID
        
        selectPositionViewController.modalPresentationStyle = .overCurrentContext
        present(selectPositionViewController, animated: false, completion: nil)
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerArray = PlayerDAO.shared.selectAll() ?? []
    
        navigationItem.title = "vs " + scheduleItem.matchOpponent
        
        matchDateLabel.text = dateFormatter.string(from: scheduleItem.matchDate)
        matchPlaceLabel.text = scheduleItem.matchPlace
        
        matchTableView.allowsSelection = false
        matchTableView.delegate = self
        matchTableView.dataSource = self
    
        // 경기 시작 전
        let compareDate = scheduleItem.matchDate.timeIntervalSince(currentDate)
        let compareHour = compareDate / 3600
        
        if compareHour > 0 {
            resultView.removeFromSuperview()
            self.view.addSubview(beforeDateLabel)
            beforeDateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            beforeDateLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
        
        if compareHour > 24 {
            beforeDateLabel.text = "경기 시작 \(Int(compareHour / 24))일 전입니다"
        }
        else if compareHour >= 1 {
            beforeDateLabel.text = "경기 시작 \(Int(compareHour) % 24)시간 전입니다"
        }
        else if compareHour > 0 {
            beforeDateLabel.text = "경기 시작 \(Int(compareHour * 60))분 전입니다"
        }
        
        // Score
        let homeScore = scheduleItem.homeScore
        let awayScore = scheduleItem.awayScore
        
        if homeScore != -1, awayScore != -1 {
            homeScoreButton.setTitle("\(homeScore)", for: .normal)
            awayScoreButton.setTitle("\(awayScore)", for: .normal)
        }
    }
    
    // MARK: Unwind
    
    @IBAction func unwindToDetailVC(segue: UIStoryboardSegue) {
        self.matchTableView.reloadData()
    }
}

// MARK: TableView Delegate, DataSource

extension DetailScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlayerDAO.shared.countAll()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "DetailScheduleTableViewCell", for: indexPath) as! DetailScheduleTableViewCell
        
        cell.playerBackNumber.text = "\(playerArray[indexPath.row].backNumber)"
        cell.playerLabel.text = playerArray[indexPath.row].name
        cell.playerResultButton.tag = indexPath.row
        cell.playerResultButton.addTarget(self,
                                          action: #selector(clickPlayerResultButton(_:)),
                                          for: .touchUpInside)
        
        let playerRecordItem = PlayerRecordDAO.shared.fetchPlayerRecordOnSchedule(
            playerID: playerArray[indexPath.row].playerID, scheduleID: scheduleItem.scheduleID)
        
        if playerRecordItem?.playerID != 0 {
            cell.playerResultButton.isEnabled = false
            cell.playerResultButton.tintColor = .black
            // Batter
            if playerRecordItem?.inning == 0 {
                let hits = (playerRecordItem?.singleHit)! + (playerRecordItem?.doubleHit)! + (playerRecordItem?.tripleHit)! + (playerRecordItem?.homeRun)!
                let atBat = hits + (playerRecordItem?.strikeOut)! + (playerRecordItem?.groundBall)! +
                    (playerRecordItem?.flyBall)!
                
                cell.playerResultButton.setTitle("\(Int(atBat))타수 \(Int(hits))안타", for: .disabled)
            }
            // Pitcher
            else {
                let pitcherInning = Int((playerRecordItem?.inning)!)
                let inningRemainder = (Int((playerRecordItem?.inning)! * 10) % 10) / 3
                let pitcherER = Int((playerRecordItem?.ER)!)
                
                if inningRemainder == 0 {
                    cell.playerResultButton.setTitle("\(pitcherInning)이닝 \(pitcherER)자책", for: .disabled)
                }
                else {
                    cell.playerResultButton.setTitle("\(pitcherInning) \(inningRemainder)/3이닝 \(pitcherER)자책", for: .disabled)
                }
            }
        }
        
        return cell
    }
}
