//
//  LeaderboardInteractor.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 21/3/23.
//

import Foundation

final class LeaderboardInteractor {

    private var presenter: LeaderboardPresenter
    private let repository: LeaderboardRepository
    private var level = Settings.shared.currentLevel
    private var players: [Player]?

    init(presenter: LeaderboardPresenter, repository: LeaderboardRepository = LeaderboardRepository()) {
        self.presenter = presenter
        self.repository = repository
    }

    func initTableView() {
        startListeningWhenDifficultyLevelChanged()
        startListeningWhenHighScoreTableChanged()
        prepareDataToDisplay()
    }

    func fetchPlayers() {
        repository.fetchPlayers(for: level, completion: { players in
            self.players = players
        })
    }

    func prepareDataToDisplay() {
        level = Settings.shared.currentLevel
        fetchPlayers()
        guard let players else {
            print("Could not fetch players.")
            return
        }
        presenter.displayPlayers(for: level, data: players)
    }
}

extension LeaderboardInteractor {
    private final func startListeningWhenDifficultyLevelChanged() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSelectedLevel(notification:)),
                                               name: NSNotification.Name.DifficultyLevelChanged,
                                               object: nil)
    }

    @objc func changeSelectedLevel(notification: Notification) {
        prepareDataToDisplay()
    }

    private final func startListeningWhenHighScoreTableChanged() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeHighScoreTable(notification:)),
                                               name: NSNotification.Name.HighScoreTableChanged,
                                               object: nil)
    }

    @objc func changeHighScoreTable(notification: Notification) {
        prepareDataToDisplay()
    }
}
