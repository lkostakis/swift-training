//
//  Writer.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 2/3/23.
//

import Foundation

class Writer {
    static let shared = Writer()

    private init() { }

    func writeToMemory() {
        if let encoded = try? JSONEncoder().encode(HighScoreTable.scoreTable) {
            UserDefaults.standard.set(encoded, forKey: "HighScoreTable")
        } else {
            print("Could not encode data.")
        }
    }
}
