//
//  ChangeLevelRepository.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 20/3/23.
//

import Foundation

class ChangeLevelRepository {
    func fetchDifficultyLevels(completion: ([Settings.DifficultyLevel]) -> Void) {
        let difficultyLevels = Settings.DifficultyLevel.allCases.map { $0 }
        completion(difficultyLevels)
    }
}
