//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 1/3/23.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var baseStatLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    func configure(name: String, baseStat: Int, type: String) {
        nameLabel.text = "Name: \(name)"
        baseStatLabel.text = "Base Stat: \(baseStat)"
        typeLabel.text = "Type: \(type)"
    }
}
