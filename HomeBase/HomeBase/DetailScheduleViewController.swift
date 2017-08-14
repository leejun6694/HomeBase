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
    
    var scheduleID: Int64!
    var matchDate: Date!
    var matchPlace: String!
    var matchOpponent: String!
    let currentDate: Date = Date()
    
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
        let alertController = UIAlertController(title: "홈 팀 점수를 입력하세요", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: configurationTextField(textField:))
        let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
            if let homeTextField = alertController.textFields?[0] {
                self.homeScoreButton.setTitle(homeTextField.text ?? "", for: .normal)
                
                TeamScheduleDAO.shared.updateHomeScore(updateScheduleID: self.scheduleID, Int64(homeTextField.text!) ?? -1)
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func clickAwayScoreButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "원정 팀 점수를 입력하세요", message: "", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: configurationTextField(textField:))
        let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
            if let awayTextField = alertController.textFields?[0] {
                self.awayScoreButton.setTitle(awayTextField.text ?? "", for: .normal)
                
                TeamScheduleDAO.shared.updateAwayScore(updateScheduleID: self.scheduleID, Int64(awayTextField.text!) ?? -1)
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
        
        let selectPositionViewController = self.storyboard!.instantiateViewController(withIdentifier: "SelectPositionViewController")
        selectPositionViewController.modalPresentationStyle = .overCurrentContext
        
        present(selectPositionViewController, animated: false, completion: nil)
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "vs " + matchOpponent
        matchDateLabel.text = dateFormatter.string(from: matchDate)
        matchPlaceLabel.text = matchPlace
        
        matchTableView.allowsSelection = false
        matchTableView.delegate = self
        matchTableView.dataSource = self
    
        // 경기 시작 전
        let compareDate = matchDate.timeIntervalSince(currentDate)
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
        let homeScore = TeamScheduleDAO.shared.findHomeScore(findScheduleID: self.scheduleID)
        let awayScore = TeamScheduleDAO.shared.findAwayScore(findScheduleID: self.scheduleID)
        
        if homeScore != -1, awayScore != -1 {
            homeScoreButton.setTitle("\(homeScore)", for: .normal)
            awayScoreButton.setTitle("\(awayScore)", for: .normal)
        }
    }
}

// MARK: TableView Delegate, DataSource

extension DetailScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailScheduleTableViewCell", for: indexPath) as! DetailScheduleTableViewCell
        
        cell.playerLabel.text = "default"
        cell.playerResultButton.addTarget(self, action: #selector(clickPlayerResultButton(_:)), for: .touchUpInside)
        
        return cell
    }
}
