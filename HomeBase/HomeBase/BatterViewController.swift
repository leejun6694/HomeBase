//
//  BatterViewController.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 15..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import UIKit

class BatterViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    var batterStackView: UIStackView = UIStackView()
    var record: PlayerRecord!
    var recordLabel: [Double] = [Double]()
    var recordLabelArray: [String] = {
        var array = ["경기 수", "타율", "타석", "타수", "득점",
                     "1루타", "2루타", "3루타", "홈런", "타점",
                     "볼넷", "사구", "삼진", "땅볼", "뜬공",
                     "희생타", "도루", "장타율", "출루율", "OPS"]
        return array
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordLabel.append(0) // 경기수
        recordLabel.append(0) // 타율
        recordLabel.append(0) // 타석
        recordLabel.append(0) // 타수
        recordLabel.append(record.run) // 득점
        recordLabel.append(record.singleHit)
        recordLabel.append(record.doubleHit)
        recordLabel.append(record.tripleHit)
        recordLabel.append(record.homeRun)
        recordLabel.append(record.RBI) // 타점
        recordLabel.append(record.baseOnBalls) // 볼넷
        recordLabel.append(record.hitByPitch) // 사구
        recordLabel.append(record.strikeOut) // 삼진
        recordLabel.append(record.groundBall) // 땅볼
        recordLabel.append(record.flyBall) // 뜬공
        recordLabel.append(record.sacrificeHit) // 희생타
        recordLabel.append(record.stolenBase) // 도루
        recordLabel.append(0) // 장타율
        recordLabel.append(0) // 출루율
        recordLabel.append(0) // ""
        initRecordStackView()

    }
    
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
