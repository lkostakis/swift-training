//
//  Reader.swift
//  Pokemon
//
//  Created by Lefteris Kostakis on 7/3/23.
//
//
import Foundation

class Reader {
    static let shared = Reader()

    private init() {}

    func readPokedexInfoFromMemory() -> PokedexInfo? {
        if let data = UserDefaults.standard.data(forKey: "PokedexInfo") {
            if let pokedexInfo = try? JSONDecoder().decode(PokedexInfo.self, from: data) {
                return pokedexInfo
            }
        }
        return nil
    }
}
