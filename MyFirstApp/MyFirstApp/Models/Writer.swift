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
        print("encoding...1")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(HighScoreTable.scoreTable) {
            print("encoding...2")
            UserDefaults.standard.set(encoded, forKey: "HighScoreTable")
        }
    }
}
