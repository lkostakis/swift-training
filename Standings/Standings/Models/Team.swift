//
//  Team.swift
//  Standings
//
//  Created by Lefteris Kostakis on 23/2/23.
//

import UIKit

struct Teams: Codable {
  let teams: [Team]
}

struct Team: Codable {
    var name: String
    var founded: Int
    var lastGame: String
    var stadium: String
    var emblem: String
    
//    static let mockTeam = Team(teamName: "", founded: 1900, lastGame: "", stadium: "", emblem: "")
    static func teamsFromBundle() -> [Team] {
        var teams: [Team] = []
        
        guard let url = Bundle.main.url(forResource: "teams", withExtension: "json") else {
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let json = try JSONDecoder().decode(Teams.self, from: data)
            teams = json.teams
        } catch {
            print("Error occured during parsing", error)
        }
        print(teams)
        return teams
    }
}
