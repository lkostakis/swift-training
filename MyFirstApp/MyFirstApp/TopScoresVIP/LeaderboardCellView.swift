//
//  LeaderboardCellView.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 22/3/23.
//

import UIKit

class LeaderboardCellView: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    static let reuseIdentifier = "\(LeaderboardCellView.self)"

    func configure(name: String, score: Int, date: Date) -> LeaderboardCellView {
        nameLabel.text = "Name: \(name)"
        scoreLabel.text = "Score: \(score)"
        dateLabel.text = "Date: \(date.displayFormat)"
        return self
    }
}
