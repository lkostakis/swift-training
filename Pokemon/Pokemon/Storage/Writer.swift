//
//  Writer.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 7/3/23.
//

import Foundation

class Writer {
    static let shared = Writer()
    
    private init() {}
    
    func writeToMemory(pokedex: Pokedex?) {
        do {
            if let pokedex = pokedex {
                let encoded = try JSONEncoder().encode(PokedexInfo(pokedex: pokedex, date: Date.now))
                UserDefaults.standard.set(encoded, forKey: "PokedexInfo")
            } else {
                print("Could not store data.")
                return
            }
        } catch {
            print("Could not encode data.")
            return
        }
    }
}

struct PokedexInfo : Codable {
    let pokedex: Pokedex
    let date: Date
}
