//
//  ViewController.swift
//  Standings
//
//  Created by Lefteris Kostakis on 22/2/23.
//

import UIKit

class StandingsHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "\(StandingsHeaderView.self)"
    @IBOutlet weak var titleLabel: UILabel!
}

class StandingsFooterView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "\(StandingsFooterView.self)"
    @IBOutlet weak var footerLabel: UILabel!
    
}

class StandingsViewController: UITableViewController {
    var teams = ["Aek", "Olympiakos", "Panaitolikos", "Panathinaikos", "Atromitos", "Paok", "Panionios",
                 "Hraklis", "Ofi", "PAS Giannena", "Asteras Tripolis", "Ionikos", "ASA", "Aigalew",
                 "Kalamaria", "Lamia", "Levadeiakos", "Larisa", "Xanthi", "Aris", "Kalamata"]
    lazy var wins = (0..<teams.count).map { _ in Int.random(in: 0..<20) }.map { String($0) }
    lazy var draws = (0..<teams.count).map { _ in Int.random(in: 0..<20) }.map { String($0) }
    lazy var loses = (0..<teams.count).map { _ in Int.random(in: 0..<20) }.map { String($0) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .systemGray6

        tableView.register(UINib(nibName: "\(TeamCell.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: TeamCell.reuseIdentifier)
        tableView.register(UINib(nibName: "\(StandingsHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: StandingsHeaderView.reuseIdentifier)
        tableView.register(UINib(nibName: "\(StandingsFooterView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: StandingsFooterView.reuseIdentifier)

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: StandingsHeaderView.reuseIdentifier) as? StandingsHeaderView
        else { return nil }

        headerView.titleLabel.text = "Team"
        headerView.titleLabel.textColor = .systemBlue
        UITableViewHeaderFooterView.appearance().tintColor = .systemGray6
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: StandingsFooterView.reuseIdentifier) as? StandingsFooterView
        else { return nil }

        footerView.footerLabel.text = "POWERED BY AFSE"
        footerView.footerLabel.textColor = .systemBlue
        UITableViewHeaderFooterView.appearance().tintColor = .systemGray6
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TeamCell.self)", for: indexPath) as? TeamCell
        else { fatalError("Could not create TeamCell") }

        let teams = teams[indexPath.row]
        let draws = draws[indexPath.row]
        let wins = wins[indexPath.row]
        let loses = loses[indexPath.row]
        
        cell.teamName.text = teams
        cell.loses.text = loses
        cell.wins.text = wins
        cell.draws.text = draws
        return cell
    }

}
