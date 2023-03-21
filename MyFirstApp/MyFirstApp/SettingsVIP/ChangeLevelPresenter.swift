//
//  ChangeLevelPresenter.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 20/3/23.
//

import Foundation

final class ChangeLevelPresenter {
    struct ChangeLevelViewModel {
        let difficultyName: String
    }

    weak var controller: ChangeLevelViewController?

    init(controller: ChangeLevelViewController) {
        self.controller = controller
    }

    func displayChangeLevel(_ difficultyLevels: [Settings.DifficultyLevel]) {
        let viewModels = difficultyLevels.map {
            let level = $0.toString()
            return ChangeLevelViewModel(difficultyName: level)
        }
        controller?.levelList = viewModels
    }

    func displayPickerView(_ index: Int) {
        controller?.displayPickerViewSelectedRow(index)
    }
}
