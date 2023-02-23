//
//  TeamCell.swift
//  Standings
//
//  Created by Lefteris Kostakis on 23/2/23.
//

import UIKit

class TeamCell: UITableViewCell {
    static let reuseIdentifier = "\(TeamCell.self)"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foundedLabel: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var lastGameLabel: UILabel!
    @IBOutlet weak var emblemImage: UIImageView!
    
    func configure(name: String, founded: String, lastGame: String, stadium: String, emblemName: String) -> TeamCell {
        nameLabel.text = name
        foundedLabel.text = founded
        lastGameLabel.text = lastGame
        stadiumLabel.text = stadium
        emblemImage.image = UIImage(named: emblemName)
      return self
    }
}
