//
//  HighScoreTable.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 2/3/23.
//

import Foundation

class HighScoreTable {
    static let shared = HighScoreTable()
    static var scoreTable: [Settings.DifficultyLevel : [Player] ] = [Settings.DifficultyLevel.tooYoungToDie : [],
                                                                     Settings.DifficultyLevel.heyNotTooRough : [],
                                                                     Settings.DifficultyLevel.hurtMePlenty : [],
                                                                     Settings.DifficultyLevel.ultraViolence : [],
                                                                     Settings.DifficultyLevel.nightmare : [] ]
    static var place: Int = 0
    static var score = 0

    private init() {}
    
    // check if is highScore based on score and level and return the position
    final func getHighScorePosition(_ score: Int, in level: Settings.DifficultyLevel) -> Int? {
        guard let highScoreTable = HighScoreTable.scoreTable[level] else {
            return nil
        }

        // When score ladder is empty, just return top1
        if highScoreTable.isEmpty {
            return 0
        }
        // if you a find a `score in table < input score` return that index
        if let position = highScoreTable.firstIndex(where: { $0.score < score }) {
            return position
        }
        // if there is not any `score in table < input score`, but table size < 3, return last index as position
        if highScoreTable.count < 3 {
            return highScoreTable.endIndex
        }
        return nil
    }
    
    final func addPlayerToHighScoreTable(player: Player) {
        guard var highScoreTable = HighScoreTable.scoreTable[Settings.shared.currentLevel] else {
            return
        }
        
        if highScoreTable.isEmpty {
            highScoreTable.append(player)
        } else if highScoreTable.count <= 3 {
            highScoreTable.insert(player, at: HighScoreTable.place)
        }
        if highScoreTable.count > 3 {
            highScoreTable.remove(at: highScoreTable.endIndex-1)
        }
        HighScoreTable.scoreTable[Settings.shared.currentLevel] = highScoreTable
    }
}

