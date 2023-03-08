//
//  Reader.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 7/3/23.
//
//
import Foundation

class Reader {
    static let reader = Reader()
    
    private init() {}
    
    func readPokedexFromMemory() -> Pokedex? {
        if let data = UserDefaults.standard.data(forKey: "Pokedex") {
            if let pokedex = try? JSONDecoder().decode(Pokedex.self, from: data) {
                return pokedex
            }
        }
        return nil
    }
}
