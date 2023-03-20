//
//  ChangeLevelPresenter.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 20/3/23.
//

import UIKit

final class ChangeLevelPresenter {
    struct ChangeLevelViewModel {
        let difficultyName: String
    }

    weak var controller: ChangeLevelViewController?

    init(controller: ChangeLevelViewController) {
        self.controller = controller
    }

    func displayChangeLevel(_ diffucultyLevels: [Settings.DifficultyLevel]) {
        let viewModels = diffucultyLevels.map {
            let level = $0.toString()
            return ChangeLevelViewModel(difficultyName: level)
        }
        self.controller?.levelList = viewModels
    }
}
