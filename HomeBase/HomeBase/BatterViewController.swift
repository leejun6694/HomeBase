//
//  BatterViewController.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 15..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class BatterViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var backgroundView: UIView!
    
    var batterStackView: UIStackView = UIStackView()
    var record: PlayerRecord!
    var recordLabel: [String] = [String]()
    
    var recordLabelArray: [String] = {
        var array = ["경기 수", "타율", "타석", "타수", "득점",
                     "1루타", "2루타", "3루타", "홈런", "타점",
                     "볼넷", "사구", "삼진", "땅볼", "뜬공",
                     "희생타", "도루", "장타율", "출루율", "OPS"]
        return array
    }()
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 3
        nf.maximumFractionDigits = 3
        
        return nf
    }()

    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let batterAppear = PlayerRecordDAO.shared.countPlayerBatterRecord(playerID: record.playerID)
        
        let hits = record.singleHit + record.doubleHit + record.tripleHit + record.homeRun
        let batterBox = hits + record.baseOnBalls + record.hitByPitch + record.strikeOut + record.groundBall + record.flyBall + record.sacrificeHit
        let atBox = hits + record.strikeOut + record.groundBall + record.flyBall
        
        var battingAverage: Double
        var sluggingPercentage: Double
        var onBaseAverage: Double
        
        if atBox == 0.0 {
            battingAverage = 0.0
            sluggingPercentage = 0.0
        }
        else {
            battingAverage = hits / atBox
            sluggingPercentage = (record.singleHit + (2 * record.doubleHit) + (3 * record.tripleHit) + (4 * record.homeRun)) / atBox
        }
        
        if batterBox == 0.0 {
            onBaseAverage = 0.0
        }
        else {
            onBaseAverage = (hits + record.baseOnBalls + record.hitByPitch) / batterBox
        }
        
        let OPS = sluggingPercentage + onBaseAverage
    
        recordLabel.append("\(batterAppear)")
        recordLabel.append("\(numberFormatter.string(from: NSNumber(value: battingAverage))!)")
        recordLabel.append("\(Int(batterBox))")
        recordLabel.append("\(Int(atBox))")
        recordLabel.append("\(Int(record.run))")
        recordLabel.append("\(Int(record.singleHit))")
        recordLabel.append("\(Int(record.doubleHit))")
        recordLabel.append("\(Int(record.tripleHit))")
        recordLabel.append("\(Int(record.homeRun))")
        recordLabel.append("\(Int(record.RBI))")
        recordLabel.append("\(Int(record.baseOnBalls))")
        recordLabel.append("\(Int(record.hitByPitch))")
        recordLabel.append("\(Int(record.strikeOut))")
        recordLabel.append("\(Int(record.groundBall))")
        recordLabel.append("\(Int(record.flyBall))")
        recordLabel.append("\(Int(record.sacrificeHit))")
        recordLabel.append("\(Int(record.stolenBase))")
        recordLabel.append("\(numberFormatter.string(from: NSNumber(value: sluggingPercentage))!)")
        recordLabel.append("\(numberFormatter.string(from: NSNumber(value: onBaseAverage))!)")
        recordLabel.append("\(numberFormatter.string(from: NSNumber(value: OPS))!)")
        initRecordStackView()

    }
    
    // MARK: RecordStackView
    
    private func initRecordStackView() {
        batterStackView.axis = .vertical
        for col in 0...3 {
            let stackView = UIStackView()
            batterStackView.addArrangedSubview(stackView)
            stackView.axis = .horizontal
            for row in 0...4 {
                let contentStackView = UIStackView()
                stackView.addArrangedSubview(contentStackView)
                contentStackView.axis = .vertical
                let titleLabel = UILabel()
                contentStackView.addArrangedSubview(titleLabel)
                titleLabel.text = recordLabelArray[col * 5 + row]
                titleLabel.textAlignment = .center
                let recordContent = UILabel()
                contentStackView.addArrangedSubview(recordContent)
                recordContent.text = "\(recordLabel[col * 5 + row])"
                recordContent.textAlignment = .center
                contentStackView.distribution = .fillEqually
            }
            stackView.distribution = .fillEqually
            stackView.spacing = 1
        }
        
        batterStackView.distribution = .fillEqually
        batterStackView.spacing = 5
        backgroundView.addSubview(batterStackView)
        batterStackView.translatesAutoresizingMaskIntoConstraints = false
        batterStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        batterStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        batterStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        batterStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
    }
}
