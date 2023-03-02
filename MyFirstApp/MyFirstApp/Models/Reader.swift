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
        
        if let savedScoreTable = (UserDefaults.standard.dictionary(forKey: "ScoreTable") as? [SettingsViewController.DifficultyLevel : [Player] ]) {
            HighScoreViewController.highScoreTable = savedScoreTable
        } else {
            print("NO DATA SAVED")
        }
        
    }
}
