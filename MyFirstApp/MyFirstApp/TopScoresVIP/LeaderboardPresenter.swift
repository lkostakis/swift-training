//
//  LeaderboardPresenter.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 21/3/23.
//

import Foundation

final class LeaderboardPresenter {
    weak var controller: LeaderboardViewController?

    init(controller: LeaderboardViewController) {
        self.controller = controller
    }

    func displayTableView() {
        controller?.tableView.estimatedRowHeight = 600
        reloadTableData()
    }

    func reloadTableData() {
        controller?.tableView.reloadData()
    }
}
