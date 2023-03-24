//
//  LeaderboardRepository.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 24/3/23.
//

import Foundation

class LeaderboardRepository {
    func fetchPlayers(for level: Settings.DifficultyLevel, completion: ([Player]) -> Void) {
        let players = HighScoreTable.scoreTable[level]

        guard let players else {
            print("Could not fetch players for level: \(level)")
            return
        }
        completion(players)
    }
}
