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
    @IBOutlet var matchTableView: UITableView!
    
    var matchDate: String!
    var matchPlace: String!
    var matchOpponent: String!
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = matchOpponent
        matchDateLabel.text = matchDate
        matchPlaceLabel.text = matchPlace
    }
}

// MARK: TableView Delegate, DataSource

extension DetailScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailScheduleTableViewCell", for: indexPath) as! DetailScheduleTableViewCell
        
        return cell
    }
}
