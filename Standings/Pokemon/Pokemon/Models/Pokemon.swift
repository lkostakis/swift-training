//
//  Pokemon.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 28/2/23.
//

import Foundation

struct Sprite: Hashable {
    let backDefault: String?
    let backShiny: String?
    let frontDefault: String?
    let frontShiny: String?
    let backFemale: String?
    let backShinyFemale: String?
    let frontFemale: String?
    let frontShinyFemale: String?
}

extension Sprite: Codable {
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case backFemale = "back_female"
        case backShinyFemale = "back_shiny_female"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct Types: Codable {
    let slot: Int
    let type: [String:String]
}

struct Stats: Hashable {
    let baseStat: Int
    let effort: Int
    let stat: [String: String]
}

extension Stats: Codable {
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct Pokemon: Codable {
    let id: Int
    let name: String
    let types: [Types]
    let weight: Int
    let sprites: Sprite
    let stats: [Stats]
}


