//
//  ChangeLevelInteractor.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 20/3/23.
//

import Foundation

final class ChangeLevelInteractor {
    private var presenter: ChangeLevelPresenter
    private let repository: ChangeLevelRepository
    private var level = Settings.shared.currentLevel
    private var difficultyLevels: [Settings.DifficultyLevel]?

    init(presenter: ChangeLevelPresenter, changeLevelRepository: ChangeLevelRepository = ChangeLevelRepository()) {
        self.presenter = presenter
        self.repository = changeLevelRepository
    }

    func viewDidLoad() {
        repository.fetchDifficultyLevels { difficultyLevels in
            self.difficultyLevels = difficultyLevels
            self.presenter.displayChangeLevel(difficultyLevels)
        }
    }

    func viewWillDisappear(_ pickerViewIndex: Int) {
        difficultyLevelChanged(pickerViewIndex)
    }

    func viewWillAppear() {
        guard let difficultyLevels,
              let indexOfLevelToShow = difficultyLevels.firstIndex(of: Settings.shared.currentLevel) else {
            return
        }
        presenter.displayPickerView(indexOfLevelToShow)
    }

    private final func difficultyLevelChanged(_ pickerViewIndex: Int) {

        guard let difficultyLevels else {
            return
        }
        let level = difficultyLevels[pickerViewIndex]

        NotificationCenter.default.post(name: NSNotification.Name.DifficultyLevelChanged,
                                        object: self,
                                        userInfo: ["level_changed": level])
    }
}
