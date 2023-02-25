//
//  MatchDetailsViewController.swift
//  Standings
//
//  Created by Lefteris Kostakis on 23/2/23.
//

import UIKit

class MatchDetailsViewController: UITableViewController {
    var team: Team
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        title = team.name
        self.tableView.contentInsetAdjustmentBehavior = .automatic
    }
    
    init?(coder: NSCoder, team: Team) {
        self.team = team
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MatchCell.self)", for: indexPath) as? MatchCell
//        else { fatalError("Could not create TeamCell") }
//
//        cell.backgroundColor = .systemGray6
//        print(team.name)
//        return cell.configure(title: "fdsafsdaf", date: "fasdfsadsd", review: "girjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerwgirjweogerw/Users/Kostakle/GitHub/swift-training/Standings/Standings/Resources/teams.jsongirjweogerwgirjweogerw")
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MatchCell.self)", for: indexPath) as? MatchCell
        else { fatalError("Could not find match.") }

        if let lastGame = team.lastGames[indexPath.row] {
          cell.configure(title: lastGame.title, date: lastGame.date, result: lastGame.result , review: lastGame.review)
      }

      return cell
    }
    

}
