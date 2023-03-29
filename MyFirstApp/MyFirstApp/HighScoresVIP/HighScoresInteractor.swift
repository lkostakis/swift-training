//
//  HighScoresInteractor.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 27/3/23.
//

import Foundation

class HighScoresInteractor {
    private var presenter: HighScoresPresenter
    private let repository: HighScoresRepository
    private var level = Settings.shared.currentLevel
    private var players: [Player]?

    init(presenter: HighScoresPresenter, repository: HighScoresRepository = HighScoresRepository()) {
        self.presenter = presenter
        self.repository = repository
    }

    func viewDidLoad() {

    }

    func viewWillAppear(_ topScoresArray: [String]?) {
        var message = "Congratulations you have achieved a top \(HighScoreTable.place+1)"
                    + "score with \(HighScoreTable.score) in \(Settings.shared.currentLevel.toString()) difficulty."

//        for (index, player) in HighScoreTable.scoreTable[Settings.shared.currentLevel]!.enumerated() {
//            topScoresArray?[index] =
//            "\(index + 1). Score: \(player.score)\nName: \(player.name)\nDate: \(player.date.displayFormat)"
//        }
    }

    func viewDidDisappear() {
        
    }

    private final func highScoreTableChanged() {
        NotificationCenter.default.post(name: NSNotification.Name.HighScoreTableChanged,
                                        object: self,
                                        userInfo: ["highscore_changed": HighScoreTable.scoreTable])
    }
}
