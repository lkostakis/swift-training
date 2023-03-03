//
//  HighScoreTable.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 2/3/23.
//

import Foundation

class HighScoreTable {
    static let shared = HighScoreTable()
    static var scoreTable: [Settings.DifficultyLevel : [Player] ] = [Settings.DifficultyLevel.tooYoungToDie : [], Settings.DifficultyLevel.heyNotTooRough : [], Settings.DifficultyLevel.hurtMePlenty : [], Settings.DifficultyLevel.ultraViolence : [], Settings.DifficultyLevel.nightmare : [] ]
    static var place: Int = 0
    static var level: Settings.DifficultyLevel = MainViewController().selectedLevel
    static var score = 0

    private init() {}
    
    // check if is highScore based on score and level and return the position
    static func getHighScorePosition(_ score: Int, in level: Settings.DifficultyLevel) -> Int? {
        guard HighScoreTable.scoreTable[level] != nil else {
            return nil
        }

        // When score ladder is empty, just return top1
        if HighScoreTable.scoreTable[level]!.isEmpty {
            return 0
        }
        // if you a find a `score in table < input score` return that index
        if let position = HighScoreTable.scoreTable[level]!.firstIndex(where: { $0.score < score }) {
            return position
        }
        // if there is not any `score in table < input score`, but table size < 3, return last index as position
        if HighScoreTable.scoreTable[level]!.count < 3 {
            return HighScoreTable.scoreTable[level]!.endIndex
        }
        return nil
    }
    
    func addPlayerToHighScoreTable(player: Player) {
        if HighScoreTable.scoreTable[HighScoreTable.level]!.isEmpty {
            HighScoreTable.scoreTable[HighScoreTable.level]!.append(player)
        } else if HighScoreTable.scoreTable[HighScoreTable.level]!.count <= 3 {
            HighScoreTable.scoreTable[HighScoreTable.level]!.insert(player, at: HighScoreTable.place)
        }
        if HighScoreTable.scoreTable[HighScoreTable.level]!.count > 3 {
            HighScoreTable.scoreTable[HighScoreTable.level]!.remove(at: HighScoreTable.scoreTable[HighScoreTable.level]!.endIndex-1)
        }
    }
}
