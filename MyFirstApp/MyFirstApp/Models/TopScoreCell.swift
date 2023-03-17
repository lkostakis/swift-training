//
//  TopScoreCell.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 3/3/23.
//

import UIKit

class TopScoreCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    static let reuseIdentifier = "\(TopScoreCell.self)"

    func configure(name: String, score: Int, date: Date) -> TopScoreCell {
        nameLabel.text = "Name: \(name)"
        scoreLabel.text = "Score: \(score)"
        dateLabel.text = "Date: \(date.displayFormat)"
        return self
    }
}
