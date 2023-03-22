//
//  LeaderboardInteractor.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 21/3/23.
//

import Foundation

final class LeaderboardInteractor {

    private var presenter: LeaderboardPresenter
    private var level = Settings.shared.currentLevel

    init(presenter: LeaderboardPresenter) {
        self.presenter = presenter
    }

    func initTableView() {
        presenter.displayTableView()
        startListeningWhenDifficultyLevelChanged()
        startListeningWhenHighScoreTableChanged()
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
        presenter.reloadTableData()
    }

    private final func startListeningWhenHighScoreTableChanged() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeHighScoreTable(notification:)),
                                               name: NSNotification.Name.HighScoreTableChanged,
                                               object: nil)
    }

    @objc func changeHighScoreTable(notification: Notification) {
        presenter.reloadTableData()
    }
}
