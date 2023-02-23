//
//  Team.swift
//  Standings
//
//  Created by Lefteris Kostakis on 23/2/23.
//

import UIKit

struct Team: Hashable {
    var teamName: String
    var loses: Int
    var draws: Int
    var wins: Int

    static let mockTeam = Team(teamName: "", loses: 0, draws: 0, wins: 0)
}

extension Team: Codable {
  enum CodingKeys: String, CodingKey {
    case teamName
    case loses
    case draws
    case wins
  }
}
