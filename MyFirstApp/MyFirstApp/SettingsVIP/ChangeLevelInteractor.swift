//
//  ChangeLevelInteractor.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 20/3/23.
//

import UIKit

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

    func viewWillDisappear(_ pickerView: UIPickerView) {
        difficultyLevelChanged(pickerView)
    }

    func viewWillAppear(_ pickerView: UIPickerView) {
        let levelToShow = difficultyLevels?.firstIndex(of: Settings.shared.currentLevel)
        pickerView.selectRow(levelToShow ?? 1, inComponent: 0, animated: true)
    }

    private final func difficultyLevelChanged(_ pickerView: UIPickerView) {

        guard let difficultyLevels else {
            return
        }
        let index = pickerView.selectedRow(inComponent: 0)
        let level = difficultyLevels[index]

        NotificationCenter.default.post(name: NSNotification.Name.DifficultyLevelChanged,
                                        object: self,
                                        userInfo: ["level_changed": level])
    }
}
