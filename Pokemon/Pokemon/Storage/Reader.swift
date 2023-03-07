//
//  Reader.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 7/3/23.
//

import Foundation

class Reader {
    static let reader = Reader()
    
    private init() {}
    
    func readFromMemory() -> Bool {
        if let data = UserDefaults.standard.data(forKey: "Pokedex") {
            if let pokedex = try? JSONDecoder().decode(Pokedex.self, from: data) {
                ViewController().pokedex = pokedex
                return true
            }
        }
        return false
    }
}
