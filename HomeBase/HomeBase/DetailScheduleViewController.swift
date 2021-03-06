//
//  DetailScheduleViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 9..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class DetailScheduleViewController: UIViewController, CustomAlertShowing {
    
    var viewController: UIViewController {
        return self
    }
    
    // MARK: Properties
    
    @IBOutlet var matchDateLabel: UILabel!
    @IBOutlet var matchPlaceLabel: UILabel!
    @IBOutlet var resultView: UIView!
    @IBOutlet var homeScoreButton: UIButton!
    @IBOutlet var awayScoreButton: UIButton!
    @IBOutlet var matchTableView: UITableView!
    
    fileprivate var playerArray = [Player]()
    private let currentDate = Date()
    var scheduleItem: TeamSchedule!
    
    var homeScore: Int = -1
    var awayScore: Int = -1
    
    private let dateFormatter: DateFormatter = {
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
        matchTableView.separatorStyle = .none
    
        let compareDate = scheduleItem.matchDate.timeIntervalSince(currentDate)
        let compareHour = compareDate / 3600
        
        // before match date
        if compareHour > 0 {
            resultView.removeFromSuperview()
            self.view.addSubview(beforeDateLabel)
            beforeDateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            beforeDateLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
        
        if compareHour > 24 {
            beforeDateLabel.text = String.localizedStringWithFormat(
                .matchAlarmDay,
                Int(compareHour / 24))
        } else if compareHour >= 1 {
            beforeDateLabel.text = String.localizedStringWithFormat(
                .matchAlarmHour,
                Int(compareHour) % 24)
        } else if compareHour > 0 {
            beforeDateLabel.text = String.localizedStringWithFormat(
                .matchAlarmMinute,
                Int(compareHour * 60))
        }
        
        homeScore = scheduleItem.homeScore
        awayScore = scheduleItem.awayScore
        
        if homeScore != -1, awayScore != -1 {
            homeScoreButton.setTitle("\(homeScore)", for: .normal)
            awayScoreButton.setTitle("\(awayScore)", for: .normal)
        }
    }
    
    // MARK: Actions
    
    @IBAction private func homeScoreButtonDidTapped(_ sender: UIButton) {
        let alertController = UIAlertController(
            title: .alertMessageOfEnterHomeTeamScore,
            message: "",
            preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: configurationTextField(textField:))
        
        let cancelAction = UIAlertAction(
            title: .cancelActionTitle,
            style: .destructive,
            handler: nil)
        let okAction = UIAlertAction(
            title: .confirmActionTitle,
            style: .default,
            handler: { (action) -> Void in
                if let homeTextField = alertController.textFields?[0] {
                self.homeScoreButton.setTitle(homeTextField.text ?? "", for: .normal)
                
                TeamScheduleDAO.shared.updateHomeScore(
                    updateScheduleID: self.scheduleItem.scheduleID, Int(homeTextField.text!) ?? -1)
                self.homeScore = Int(homeTextField.text!) ?? -1
            }
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction private func awayScoreButtonDidTapped(_ sender: UIButton) {
        let alertController = UIAlertController(
            title: .alertMessageOfEnterOpponetTeamScore,
            message: "",
            preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: configurationTextField(textField:))
        
        let cancelAction = UIAlertAction(
            title: .cancelActionTitle,
            style: .destructive,
            handler: nil)
        let okAction = UIAlertAction(
            title: .confirmActionTitle,
            style: .default,
            handler: { (action) -> Void in
            if let awayTextField = alertController.textFields?[0] {
                self.awayScoreButton.setTitle(awayTextField.text ?? "", for: .normal)
                
                TeamScheduleDAO.shared.updateAwayScore(
                    updateScheduleID: self.scheduleItem.scheduleID, Int(awayTextField.text!) ?? -1)
                self.awayScore = Int(awayTextField.text!) ?? -1
            }
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func configurationTextField(textField: UITextField) {
        textField.placeholder = ""
        textField.keyboardType = .numberPad
    }
    
    @objc fileprivate func playerResultButtonDidTapped(_ sender: UIButton) {
        if homeScore == -1 || awayScore == -1 {
            showAlertOneButton(
                title: .alertActionTitle,
                message: .alertMessageOfEnterMatchResultFirst)
        } else {
            let buttonRow = sender.tag
            
            let selectPositionViewController = self.storyboard!.instantiateViewController(
                withIdentifier: .selectPositionViewController) as! SelectPositionViewController
            
            selectPositionViewController.row = buttonRow
            selectPositionViewController.playerID = self.playerArray[buttonRow].playerID
            selectPositionViewController.scheduleID = self.scheduleItem.scheduleID
            
            selectPositionViewController.modalPresentationStyle = .overCurrentContext
            
            let presenter: UIViewController = self.tabBarController ?? self
            
            presenter.present(selectPositionViewController, animated: false, completion: nil)
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
            withIdentifier: .detailScheduleTableViewCell, for: indexPath) as! DetailScheduleTableViewCell
        
        cell.playerBackNumber.text = "\(playerArray[indexPath.row].backNumber)"
        cell.playerLabel.text = playerArray[indexPath.row].name
        cell.playerResultButton.tag = indexPath.row
        
        cell.playerResultButton.setTitle(
            .alertTitleOfEnterResult,
            for: .normal)
        cell.playerResultButton.addTarget(
            self,
            action: #selector(playerResultButtonDidTapped(_:)),
            for: .touchUpInside)
        
        if let playerRecordItem = PlayerRecordDAO.shared.selectPlayerRecordOnSchedule(
            playerID: playerArray[indexPath.row].playerID, scheduleID: scheduleItem.scheduleID) {
            
            if playerRecordItem.playerID != 0 {
                let sumOfPlayerRecord = PlayerRecordDAO.shared.selectSumOfPlayerRecord(
                    playerRecordID: playerRecordItem.playerRecordID)
                let sumOfBatterRecord = PlayerRecordDAO.shared.selectSumOfBatterRecord(
                    playerRecordID: playerRecordItem.playerRecordID)
                
                if sumOfPlayerRecord == 0 {
                    cell.playerResultButton.setTitle(
                        .alertTitleOfEnterResult,
                        for: .normal)
                } else if sumOfBatterRecord != 0 {
                    let hits = (playerRecordItem.singleHit) +
                        (playerRecordItem.doubleHit) +
                        (playerRecordItem.tripleHit) +
                        (playerRecordItem.homeRun)
                    let atBat = hits + (playerRecordItem.strikeOut) +
                        (playerRecordItem.groundBall) +
                        (playerRecordItem.flyBall)
    
                    cell.playerResultButton.setTitle( String.localizedStringWithFormat(
                    .atBatAndHit, Int(atBat), Int(hits)), for: .normal)
                } else {
                    let pitcherInning = Int((playerRecordItem.inning))
                    let inningRemainder = (Int((playerRecordItem.inning) * 10) % 10) / 3
                    let pitcherER = Int((playerRecordItem.ER))
                    
                    if inningRemainder == 0 {
                        cell.playerResultButton.setTitle( String.localizedStringWithFormat(
                            .inningAndER, pitcherInning, pitcherER), for: .normal)
                    } else {
                        cell.playerResultButton.setTitle( String.localizedStringWithFormat(
                            .threeInningAndER,
                            pitcherInning,
                            inningRemainder,
                            pitcherER), for: .normal)
                    }
                }
            }
        }
        
        return cell
    }
}
