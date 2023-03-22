//
//  LeaderboardViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 21/3/23.
//

import UIKit

class LeaderboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var interactor: LeaderboardInteractor!

    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter = LeaderboardPresenter(controller: self)
        interactor = LeaderboardInteractor(presenter: presenter)
        title = "Leaders"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "\(LeaderboardCellView.self)", bundle: nil),
                           forCellReuseIdentifier: LeaderboardCellView.reuseIdentifier)
        tableView.register(UINib(nibName: "\(LeaderboardHeaderView.self)", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: LeaderboardHeaderView.reuseIdentifier)
        print("ok")
        interactor.initTableView()
    }
}

class LeaderboardHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "\(LeaderboardHeaderView.self)"
    @IBOutlet weak var headerLabel: UILabel!
}

extension LeaderboardViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 { return nil }
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: LeaderboardHeaderView.reuseIdentifier) as? LeaderboardHeaderView
        else { return nil }

        headerView.headerLabel.text = "Top Scores Table: \(Settings.shared.currentLevel.toString())"
        headerView.headerLabel.textColor = .systemBlue
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let players = HighScoreTable.scoreTable[Settings.shared.currentLevel] else {
            return 0
        }
        return section == 0 ? 0 : players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                        "\(LeaderboardCellView.self)", for: indexPath) as? LeaderboardCellView else {
            return UITableViewCell()
        }

        guard let players = HighScoreTable.scoreTable[Settings.shared.currentLevel], !players.isEmpty else {
            return UITableViewCell()
        }

        return cell.configure(name: players[indexPath.row].name, score: players[indexPath.row].score,
                              date: players[indexPath.row].date)
    }
}
