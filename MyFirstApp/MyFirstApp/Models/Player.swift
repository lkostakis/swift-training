//
//  Player.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 21/2/23.
//

import Foundation

class Player : Codable {
    var name: String
    var score: Int
    var date: Date
    
    init(name: String, score: Int, date: Date) {
        self.name = name
        self.score = score
        self.date = date
    }
    
    var description: String { "Name: \(name), Score: \(score), Date: \(date)" }

}
