//
//  HighScoresRepository.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 27/3/23.
//

import Foundation

class HighScoresRepository {
    func fetchPlayers(for level: Settings.DifficultyLevel, completion: ([Player]) -> Void) {
        let players = HighScoreTable.scoreTable[level]

        guard let players else {
            print("Could not fetch players for level: \(level)")
            return
        }
        completion(players)
    }
}
