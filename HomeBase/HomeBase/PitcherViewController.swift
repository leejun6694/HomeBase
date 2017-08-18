//
//  PitcherViewController.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 15..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class PitcherViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var backgroundView: UIView!
    
    var pitcherStackView: UIStackView = UIStackView()
    var record: PlayerRecord!
    var recordLabel: [String] = [String]()
    var recordLabelArray: [String] = {
        var array = ["경기 수", "방어율", "이닝", "자책점",
                     "승리", "패배", "홀드", "세이브",
                     "탈삼진", "볼넷", "사구", "피안타",
                     "피홈런", "WHIP", "K/9", "K/BB"]
        return array
    }()
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        
        return nf
    }()
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pitcherAppear = PlayerRecordDAO.shared.countPlayerPitcherRecord(playerID: record.playerID)
        
        var ERA: Double
        var WHIP: Double
        
        if record.inning == 0 {
            ERA = 0.0
            WHIP = 0.0
        }
        else {
            ERA = (record.ER * 9) / record.inning
            WHIP = (record.walks + record.hits) / record.inning
        }
        
        var strikeOutDividedBaseOnBalls: Double
        if (record.walks + record.hitBatters) == 0 {
            strikeOutDividedBaseOnBalls = 0.0
        }
        else {
            strikeOutDividedBaseOnBalls = record.strikeOuts / (record.walks + record.hitBatters)
        }
        
        let inningRemainder = (Int(record.inning * 10) % 10) / 3
        let inning = Int(record.inning)
        
        recordLabel.append("\(pitcherAppear)")
        recordLabel.append("\(numberFormatter.string(from: NSNumber(value: ERA))!)")
        if inningRemainder == 0 {
            recordLabel.append("\(inning)")
        }
        else {
            recordLabel.append("\(inning) \(inningRemainder)/3")
        }
        recordLabel.append("\(Int(record.ER))")
        
        recordLabel.append("\(Int(record.win))")
        recordLabel.append("\(Int(record.lose))")
        recordLabel.append("\(Int(record.hold))")
        recordLabel.append("\(Int(record.save))")
        
        recordLabel.append("\(Int(record.strikeOuts))")
        recordLabel.append("\(Int(record.walks))")
        recordLabel.append("\(Int(record.hitBatters))")
        recordLabel.append("\(Int(record.hits))")
        
        recordLabel.append("\(Int(record.homeRuns))")
        recordLabel.append("\(numberFormatter.string(from: NSNumber(value: WHIP))!)")
        recordLabel.append("\(numberFormatter.string(from: NSNumber(value: record.strikeOuts/9.0))!)")
        recordLabel.append("\(numberFormatter.string(from: NSNumber(value: strikeOutDividedBaseOnBalls))!)")
        
        initRecordStackView()
    }
    
    // MARK: RecordStackView
    
    private func initRecordStackView() {
        pitcherStackView.axis = .vertical
        
        for col in 0...3 {
            let stackView = UIStackView()
            pitcherStackView.addArrangedSubview(stackView)
            stackView.axis = .horizontal
            for row in 0...3 {
                let contentStackView = UIStackView()
                stackView.addArrangedSubview(contentStackView)
                contentStackView.axis = .vertical
                let titleLabel = UILabel()
                contentStackView.addArrangedSubview(titleLabel)
                titleLabel.text = recordLabelArray[col * 4 + row]
                titleLabel.textAlignment = .center
                let recordContent = UILabel()
                contentStackView.addArrangedSubview(recordContent)
                recordContent.text = "\(recordLabel[col * 4 + row])"
                recordContent.textAlignment = .center
                contentStackView.distribution = .fillEqually
            }
            stackView.distribution = .fillEqually
            stackView.spacing = 1
        }
        pitcherStackView.distribution = .fillEqually
        pitcherStackView.spacing = 5
        backgroundView.addSubview(pitcherStackView)
        pitcherStackView.translatesAutoresizingMaskIntoConstraints = false
        pitcherStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        pitcherStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        pitcherStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        pitcherStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
    }
}
