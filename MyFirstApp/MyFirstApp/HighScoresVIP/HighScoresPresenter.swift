//
//  HighScoresPresenter.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 27/3/23.
//

import Foundation

class HighScoresPresenter {

    weak var controller: HighScoresViewController?

    init(controller: HighScoresViewController) {
        self.controller = controller
    }
}
