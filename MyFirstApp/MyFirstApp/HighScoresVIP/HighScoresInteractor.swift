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

    func viewWillAppear() {
        fetchPlayers()
        guard let players else {
            print("No players retrieved.")
            return
        }
        presenter.displayHighScores(for: level, players)
    }

    func viewDidDisappear() {
        highScoreTableChanged()
        Writer.shared.writeToMemory()
    }

    func fetchPlayers() {
        repository.fetchPlayers(for: level, completion: { players in
            self.players = players
        })
    }

    func addPlayerToTable(_ player: Player) {
        HighScoreTable.shared.addPlayerToHighScoreTable(player: player)
    }

    private final func highScoreTableChanged() {
        NotificationCenter.default.post(name: NSNotification.Name.HighScoreTableChanged,
                                        object: self,
                                        userInfo: ["highscore_changed": HighScoreTable.scoreTable])
    }
}
