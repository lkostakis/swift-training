//
//  ViewController.swift
//  Standings
//
//  Created by Lefteris Kostakis on 22/2/23.
//

import UIKit

class StandingsViewController: UITableViewController {
    var teams = ["Aek", "Olympiakos", "Panaitolikos", "Panathinaikos", "Atromitos", "Paok", "Panionios",
                 "Aek", "Olympiakos", "Panaitolikos", "Panathinaikos", "Atromitos", "Paok", "Panionios",
                 "Aek", "Olympiakos", "Panaitolikos", "Panathinaikos", "Atromitos", "Paok", "Panionios"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .systemGray6
        
        tableView.register(UINib(nibName: "\(TeamCell.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: TeamCell.reuseIdentifier)

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
        cell.teamName.text = teams
        cell.loses.text = "123456"
        cell.wins.text = "123456"
        cell.draws.text = "123456"
        return cell
    }

}
