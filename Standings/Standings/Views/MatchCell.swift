//
//  MatchReviewCell.swift
//  Standings
//
//  Created by Lefteris Kostakis on 24/2/23.
//

import UIKit

class MatchCell: UITableViewCell {
    static let reuseIdentifier = "\(MatchCell.self)"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var groundLabel: UILabel!
    static let openMatchReview = "Match Details >"
    
    func configure(title: String, date: String, ground: String, result: String, review: String, isExpanded: Bool) -> MatchCell {
        titleLabel.text = "Game: \(title)"
        dateLabel.text = "Date: \(date)"
        groundLabel.text = "Ground: \(ground)"
        resultLabel.text = "Result: \(result)"
        reviewLabel.text = isExpanded ? review : Self.openMatchReview
        reviewLabel.textAlignment = isExpanded ? .left : .center
        reviewLabel.textColor = isExpanded ? UIColor(red: 0, green: 0, blue: 0, alpha: 1) : .systemRed
        selectionStyle = .none
        return self
    }
    
}
