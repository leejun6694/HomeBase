//
//  SquadMainViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2017. 8. 7..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class SquadMainViewController: UIViewController {
    
    var playerArray = [Player]()
    var playerRecord: PlayerRecord!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
//        let calendar = Calendar(identifier:  .gregorian)
//        let date1 = calendar.date(from: DateComponents(year: 2017, month:  9, day: 11))
//        let date2 = calendar.date(from: DateComponents(year: 2017, month:  9, day: 20))
//        let schedule1 = TeamSchedule(matchOpponent: "야구야구", matchDate: date1!, matchPlace: "서울")
//        let schedule2 = TeamSchedule(matchOpponent: "둘째에요", matchDate: date2!, matchPlace: "부산")
//        TeamScheduleDAO.shared.insert(insertTeamSchedule: schedule1)
//        TeamScheduleDAO.shared.insert(insertTeamSchedule: schedule2)
        
//        let record = PlayerRecord(playerID: 1, scheduleID: 1, singleHit: 3, doubleHit: 1, tripleHit: 1, homeRun: 0, baseOnBalls: 0, strikeOut: 1, groundBall: 1, flyBall: 2, sacrificeHit: 3, stolenBase: 1, run: 3, RBI: 1)
//        PlayerRecordDAO.shared.insert(playerRecordObject: record)
//        
//        let record2 = PlayerRecord(playerID: 1, scheduleID: 2, singleHit: 1, doubleHit: 0, tripleHit: 0, homeRun: 1, baseOnBalls: 2, strikeOut: 0, groundBall: 0, flyBall: 0, sacrificeHit: 1, stolenBase: 0, run: 2, RBI: 0)
//        PlayerRecordDAO.shared.insert(playerRecordObject: record2)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerArray = PlayerDAO.shared.selectAll()!
        print(playerArray.count)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSquadMainToPageControl" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let selectedPlayer = playerArray[row]
                let squadPlayerRecordViewController = segue.destination as! SquadPlayerRecordViewController
                self.playerRecord = PlayerRecordDAO.shared.selectOnPlayer(id: selectedPlayer.playerID)
                print("main to page")
                print(self.playerRecord.baseOnBalls)
                squadPlayerRecordViewController.player = selectedPlayer
                squadPlayerRecordViewController.playerRecord = self.playerRecord
                
                if let squadPlayerRecordPageViewController = segue.destination as? SquadPlayerRecordPageViewController {
                    //squadPlayerRecordPageViewController.positionDelegate = self
                    squadPlayerRecordPageViewController.player = selectedPlayer
                    squadPlayerRecordPageViewController.playerRecord = self.playerRecord
                }
                if let batterViewController = segue.destination as? BatterViewController {
                    batterViewController.record = playerRecord
                }

                
                
            }
        }
    }
    
    @IBAction func addButtonDidTap(_ sender: UIBarButtonItem) {
        guard let squadAddPlayerViewController = storyboard?.instantiateViewController(withIdentifier: "SquadAddPlayerViewController") else { return }
        present(squadAddPlayerViewController, animated: true, completion: nil)
    }
}

extension SquadMainViewController: UITableViewDataSource {
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
}
