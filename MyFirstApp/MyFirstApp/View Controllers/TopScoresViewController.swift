//
//  TopScoresViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 20/2/23.
//

import UIKit

class TopScoresHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "\(TopScoresHeaderView.self)"
    @IBOutlet weak var headerLabel: UILabel!
}

class TopScoresViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Leaders"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.register(UINib(nibName: "\(TopScoreCell.self)", bundle: nil),
                           forCellReuseIdentifier: TopScoreCell.reuseIdentifier)
        tableView.register(UINib(nibName: "\(TopScoresHeaderView.self)", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: TopScoresHeaderView.reuseIdentifier)
        startListeningWhenDifficultyLevelChanged()
        startListeningWhenHighScoreTableChanged()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 { return nil }
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TopScoresHeaderView.reuseIdentifier) as? TopScoresHeaderView
        else { return nil }

        headerView.headerLabel.text = "Top Scores Table: \(Settings.shared.currentLevel.toString())"
        headerView.headerLabel.textColor = .systemBlue
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let players = HighScoreTable.scoreTable[Settings.shared.currentLevel] else {
            return 0
        }
        return section == 0 ? 0 : players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        "\(TopScoreCell.self)", for: indexPath) as? TopScoreCell else {
            return UITableViewCell()
        }

        guard let players = HighScoreTable.scoreTable[Settings.shared.currentLevel], !players.isEmpty else {
            return UITableViewCell()
        }
        return cell.configure(name: players[indexPath.row].name, score: players[indexPath.row].score,
                              date: players[indexPath.row].date)
    }

}

extension TopScoresViewController {
    private final func startListeningWhenDifficultyLevelChanged() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSelectedLevel(notification:)),
                                               name: NSNotification.Name.DifficultyLevelChanged,
                                               object: nil)
    }

    @objc func changeSelectedLevel(notification: Notification) {
        tableView.reloadData()
    }

    private final func startListeningWhenHighScoreTableChanged() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeHighScoreTable(notification:)),
                                               name: NSNotification.Name.HighScoreTableChanged,
                                               object: nil)
    }

    @objc func changeHighScoreTable(notification: Notification) {
        tableView.reloadData()
    }
}
