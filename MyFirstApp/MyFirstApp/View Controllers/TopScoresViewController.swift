//
//  TopScoresViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 20/2/23.
//

import UIKit

class TopScoresViewController: UITableViewController {

    private var level: Settings.DifficultyLevel?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Leaders"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.register(UINib(nibName: "\(TopScoreCell.self)", bundle: nil), forCellReuseIdentifier: TopScoreCell.reuseIdentifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard self.level != nil else {
            return 0
        }

        return 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        guard let level = Settings.DifficultyLevel(rawValue: Settings.currentLevel!) else {
            return
        }
        self.level = level
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let level = self.level else {
            return 0
        }
        
        if HighScoreTable.scoreTable[level]?.count == 0 {
            return 1
        }
        
        return HighScoreTable.scoreTable[level]?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TopScoreCell.self)", for: indexPath) as? TopScoreCell else {
            return UITableViewCell()
        }
        
        guard let level = self.level, let players = HighScoreTable.scoreTable[level], !players.isEmpty else {
            return cell.configure(name: "No player yet.", score: 0, date: Date.now)
        }

        return cell.configure(name: players[indexPath.row].name, score: players[indexPath.row].score, date: players[indexPath.row].date)
    }
}
