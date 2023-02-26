//
//  Match.swift
//  Standings
//
//  Created by Lefteris Kostakis on 24/2/23.
//

import UIKit

struct Match: Codable {
    let title: String
    let date: String
    let result: String
    let ground: String
    let review: String
    var isExpanded: Bool

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        date = try container.decode(String.self, forKey: .date)
        ground = try container.decode(String.self, forKey: .ground)
        review = try container.decode(String.self, forKey: .review)
        result = try container.decode(String.self, forKey: .result)
        isExpanded = false
    }
}
