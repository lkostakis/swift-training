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
        print("starting read...1")
        if let data = UserDefaults.standard.data(forKey: "HighScoreTable") {
            let decoder = JSONDecoder()
            if let highScoreTable = try? decoder.decode([Settings.DifficultyLevel : [Player]].self, from: data) {
                HighScoreTable.scoreTable = highScoreTable
            }
        } else {
            print("nothing to read")
        }
    }
}
