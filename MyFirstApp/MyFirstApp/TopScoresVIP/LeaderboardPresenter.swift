//
//  LeaderboardPresenter.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 21/3/23.
//

import Foundation

final class LeaderboardPresenter {

    struct PlayerViewModel {
        var name: String
        var date: Date
        var score: Int
    }

    struct HeaderViewModel {
        var title: String
    }

    weak var controller: LeaderboardViewController?

    init(controller: LeaderboardViewController) {
        self.controller = controller
    }

    func displayPlayers(for level: Settings.DifficultyLevel, data players: [Player]) {
        let viewModels = players.map {
            return PlayerViewModel(name: $0.name, date: $0.date, score: $0.score)
        }
        controller?.header = HeaderViewModel(title: level.toString())
        controller?.players = viewModels
    }
}
