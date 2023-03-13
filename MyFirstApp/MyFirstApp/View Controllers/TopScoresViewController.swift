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

    private var level: Settings.DifficultyLevel?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Leaders"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.register(UINib(nibName: "\(TopScoreCell.self)", bundle: nil), forCellReuseIdentifier: TopScoreCell.reuseIdentifier)
        tableView.register(UINib(nibName: "\(TopScoresHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: TopScoresHeaderView.reuseIdentifier)
        startListeningWhenDifficultyLevelChanged()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 { return nil }
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TopScoresHeaderView.reuseIdentifier) as? TopScoresHeaderView
        else { return nil }

        headerView.headerLabel.text = "Top Scores Table: \(level?.toString() ?? "Unknown level")"
        headerView.headerLabel.textColor = .systemBlue
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let level = self.level else {
            return 0
        }
        return section == 0 ? 0 : HighScoreTable.scoreTable[level]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TopScoreCell.self)", for: indexPath) as? TopScoreCell else {
            return UITableViewCell()
        }

        guard let level = self.level, let players = HighScoreTable.scoreTable[level], !players.isEmpty else {
            return UITableViewCell()
        }

        return cell.configure(name: players[indexPath.row].name, score: players[indexPath.row].score, date: players[indexPath.row].date)
    }
    
    private final func startListeningWhenDifficultyLevelChanged() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSelectedLevel(notification:)),
                                               name: NSNotification.Name.DifficultyLevelChanged,
                                               object: nil)
    }

    @objc func changeSelectedLevel(notification: Notification) {
        if let level = notification.userInfo?["level_changed"] as? Settings.DifficultyLevel {
            self.level = level
            tableView.reloadData()
        }
    }

    private final func stopListeningWhenDifficultyLevelChanged() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.DifficultyLevelChanged,
                                                  object: nil)
    }
}
