//
//  Reader.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 2/3/23.
//

import Foundation

class Reader {
    static let shared = Reader()
    
    private init() { }
    
    static func readFromMemory() {
        if let data = UserDefaults.standard.data(forKey: "HighScoreTable") {
            if let highScoreTable = try? JSONDecoder().decode([Settings.DifficultyLevel : [Player]].self, from: data) {
                HighScoreTable.scoreTable = highScoreTable
            }
        } else {
            print("No data to read.")
        }
    }
}
