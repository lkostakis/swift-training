//
//  HighScoresPresenter.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 27/3/23.
//

import Foundation

class HighScoresPresenter {

    struct PlayerModel {
        var name: String
        var score: String
        var date: String
    }

    weak var controller: HighScoresViewController?

    init(controller: HighScoresViewController) {
        self.controller = controller
    }

    func displayHighScores(for level: Settings.DifficultyLevel, _ players: [Player]) {
        let message = "Congratulations you have achieved a top \(HighScoreTable.place+1) " +
                      "score with \(HighScoreTable.score) in \(level.toString()) difficulty."

        controller?.messageText = message

        let playersViewModels = players.enumerated().map { index, player in
            let score = "\(index + 1). Score: \(player.score)\n"
            let name = "Name: \(player.name)\n"
            let date = "Date: \(player.date.displayFormat)"
            return PlayerModel(name: name, score: score, date: date)
        }
        controller?.topThreePlayersList = playersViewModels
    }
}
