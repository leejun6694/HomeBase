//
//  PitcherViewController.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 15..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class PitcherViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    
    var pitcherStackView: UIStackView = UIStackView()
    var record: PlayerRecord!
    var recordLabel: [Double] = [Double]()
    var recordLabelArray: [String] = {
        var array = ["경기 수", "방어율", "이닝", "자책점",
                     "승리", "패배", "홀드", "세이브",
                     "탈삼진", "볼넷", "사구", "피안타",
                     "피홈런", "WHIP", "K/9", "K/BB"]
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordLabel.append(0) // 경기수
        recordLabel.append(0) // 방어율
        recordLabel.append(record.inning) // 이닝
        recordLabel.append(record.ER) // 자책점
        
        recordLabel.append(record.win) // 승리
        recordLabel.append(record.lose) // 패배
        recordLabel.append(record.hold) // 홀드
        recordLabel.append(record.save) // 세이브
        
        recordLabel.append(record.strikeOuts) // 탈삼진
        recordLabel.append(record.walks) // 볼넷
        recordLabel.append(record.hitBatters) // 사구
        recordLabel.append(record.hits) // 피안타
        
        recordLabel.append(record.homeRuns) // 피홈런
        recordLabel.append(record.walks + record.hits) // WHIP
        recordLabel.append(0) // K/9
        recordLabel.append(0) // K/BB
        initRecordStackView()
    }
    
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
