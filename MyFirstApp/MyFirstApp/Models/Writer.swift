//
//  Writer.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 2/3/23.
//

import Foundation


class Writer {
    static let shared = Writer()
    
    private init() { }
    
    static func writeToMemory() {
        UserDefaults.standard.set(HighScoreViewController.highScoreTable, forKey: "ScoreTable")
    }
}
