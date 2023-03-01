//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 1/3/23.
//

import UIKit

class PokedexCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var URLLabel: UILabel!
    func configure(name: String, url: String) -> PokedexCell {
        nameLabel.text = name
        URLLabel.text = url
        return self
    }
}
