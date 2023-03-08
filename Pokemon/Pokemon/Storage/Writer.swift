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
            let encoded = try JSONEncoder().encode(pokedex)
            UserDefaults.standard.set(encoded, forKey: "Pokedex")
        } catch {
            print("Could not encode data.")
        }
    }
}
