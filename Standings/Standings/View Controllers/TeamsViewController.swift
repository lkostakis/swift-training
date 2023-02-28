//
//  ViewController.swift
//  Standings
//
//  Created by Lefteris Kostakis on 22/2/23.
//

import UIKit

class TeamsViewController: UITableViewController {
    let teams = Team.teamsFromBundle()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .systemGray5
        tableView.register(UINib(nibName: "\(TeamsHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: TeamsHeaderView.reuseIdentifier)
        tableView.register(UINib(nibName: "\(TeamsFooterView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: TeamsFooterView.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.sectionHeaderTopPadding = 0
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TeamsHeaderView.reuseIdentifier) as? TeamsHeaderView
        else { return nil }
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TeamsFooterView.reuseIdentifier) as? TeamsFooterView
        else { return nil }
        footerView.footerLabel.font = footerView.footerLabel.font.withSize(12)
        footerView.footerLabel.textColor = .systemGray2
        footerView.footerLabel.text = "Powered by COSMOTE"
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
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
