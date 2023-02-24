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
    let name: String
    let founded: Int
    let lastGame: String
    let stadium: String
    let emblem: String
    let abstract: String

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
        return teams
    }
    
    enum CodingKeys: CodingKey {
        case name
        case founded
        case lastGame
        case stadium
        case emblem
        case abstract
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Team.CodingKeys> = try decoder.container(keyedBy: Team.CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: Team.CodingKeys.name)
        self.founded = try container.decode(Int.self, forKey: Team.CodingKeys.founded)
        self.lastGame = try container.decode(String.self, forKey: Team.CodingKeys.lastGame)
        self.stadium = try container.decode(String.self, forKey: Team.CodingKeys.stadium)
        self.emblem = try container.decode(String.self, forKey: Team.CodingKeys.emblem)
        self.abstract = try container.decode(String.self, forKey: Team.CodingKeys.abstract)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Team.CodingKeys> = encoder.container(keyedBy: Team.CodingKeys.self)
        
        try container.encode(self.name, forKey: Team.CodingKeys.name)
        try container.encode(self.founded, forKey: Team.CodingKeys.founded)
        try container.encode(self.lastGame, forKey: Team.CodingKeys.lastGame)
        try container.encode(self.stadium, forKey: Team.CodingKeys.stadium)
        try container.encode(self.emblem, forKey: Team.CodingKeys.emblem)
        try container.encode(self.abstract, forKey: Team.CodingKeys.abstract)
    }
}
