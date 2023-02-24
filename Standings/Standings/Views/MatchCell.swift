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
    
    func configure(title: String, date: String, review: String) -> MatchCell {
        titleLabel.text = title
        dateLabel.text = date
        reviewLabel.text = review
        return self
    }
    
}
