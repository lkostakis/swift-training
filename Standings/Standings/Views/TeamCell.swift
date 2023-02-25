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
    @IBOutlet weak var abstractLabel: UILabel!
    
    
    func configure(name: String, founded: String, stadium: String, emblemName: String, abstract: String) -> TeamCell {
        nameLabel.text = name
        foundedLabel.text = "Founded: \(founded)"
        stadiumLabel.text = "Ground: \(stadium)"
        emblemImage.image = UIImage(named: emblemName)
        abstractLabel.text = "Abstract: \(abstract)"
      return self
    }
}
