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
    @IBOutlet weak var pokemonImage: UIImageView!
    
    func configure(name: String, url: String) -> PokedexCell {
        nameLabel.text = name
        URLLabel.text = url
        return self
    }
    
    func configure(name: String, url: String, image: UIImage) -> PokedexCell {
        nameLabel.text = name
        URLLabel.text = url
        pokemonImage.image = image
        return self
    }
}
