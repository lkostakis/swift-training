//
//  ViewController.swift
//  Standings
//
//  Created by Lefteris Kostakis on 22/2/23.
//

import UIKit

//class StandingsHeaderView: UITableViewHeaderFooterView {
//    static let reuseIdentifier = "\(StandingsHeaderView.self)"
//    @IBOutlet weak var titleLabel: UILabel!
//}
//
//class StandingsFooterView: UITableViewHeaderFooterView {
//    static let reuseIdentifier = "\(StandingsFooterView.self)"
//    @IBOutlet weak var footerLabel: UILabel!
//
//}

class StandingsViewController: UITableViewController {
    let teams = Team.teamsFromBundle()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .systemGray5

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
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
        
        let team = teams[indexPath.row]
        cell.backgroundColor = .systemGray6
        return cell.configure(name: team.name, founded: String(team.founded), stadium: team.stadium,
                              emblemName: team.emblem, abstract: team.abstract)
    }

    @IBSegueAction func showMatchDetails(_ coder: NSCoder) -> MatchDetailsViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Nothing selected!")
        }
        let team = teams[indexPath.row]
        return MatchDetailsViewController(coder: coder, team: team)
    }
    

}
