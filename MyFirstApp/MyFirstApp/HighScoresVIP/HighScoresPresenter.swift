//
//  HighScoresPresenter.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 27/3/23.
//

import Foundation

class HighScoresPresenter {

    weak var controller: HighScoresViewController?

    init(controller: HighScoresViewController) {
        self.controller = controller
    }

    func displayHighScores(for level: Settings.DifficultyLevel, _ players: [Player]) {
        let message = "Congratulations you have achieved a top \(HighScoreTable.place+1)"
                    + "score with \(HighScoreTable.score) in \(level.toString()) difficulty."

        controller?.messageText = message

        var topScoreLabels = [controller?.topScore1Text, controller?.topScore2Text, controller?.topScore3Text]
        players.enumerated().map { index, player in
            if player.name == "" {
                player.name = "No name entered."
            }
            topScoreLabels[index] = "\(index + 1). Score: \(player.score)\n" +
                                    "Name: \(player.name)\n" +
                                    "Date: \(player.date.displayFormat)"
        }
    }
}
