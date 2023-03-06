//
//  Pokedex.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 1/3/23.
//
import Foundation

struct Pokedex: Codable {
    let results: [PokemonName]?
}

struct PokemonName: Codable {
    let name: String?
    let url: String?
    var pokemonID: String {
        URL(string: url!)!.lastPathComponent
    }
}
