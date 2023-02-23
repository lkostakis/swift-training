//
//  File.swift
//  Standings
//
//  Created by Lefteris Kostakis on 23/2/23.
//

import UIKit

class TeamCell: UITableViewCell {
    static let reuseIdentifier = "\(TeamCell.self)"

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var draws: UILabel!
    @IBOutlet weak var loses: UILabel!
}
