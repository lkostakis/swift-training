//
//  HighScoreViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 17/2/23.
//

import UIKit

extension Collection {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

class Player : CustomStringConvertible {
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


class HighScoreViewController: UIViewController {
    static let shared = HighScoreViewController()
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var topScore1: UILabel!
    @IBOutlet weak var topScore2: UILabel!
    @IBOutlet weak var topScore3: UILabel!
    private static var highScoreTable: [SettingsViewController.DifficultyLevel : [Player] ] = [SettingsViewController.DifficultyLevel.tooYoungToDie : [], SettingsViewController.DifficultyLevel.heyNotTooRough : [], SettingsViewController.DifficultyLevel.hurtMePlenty : [], SettingsViewController.DifficultyLevel.ultraViolence : [], SettingsViewController.DifficultyLevel.nightmare : [] ]
    var place: Int = 0
    var level: SettingsViewController.DifficultyLevel = ViewController().selectedLevel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private init() { super.init(nibName: nil, bundle: nil) }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        message.font = UIFont.boldSystemFont(ofSize: 20)
        message.text = "Congratulations you have achieved a top \(place) score in \(level.toString()) difficulty."
        [topScore1, topScore2, topScore3].enumerated().forEach { (index, label) in
                label!.text = "\(index + 1). Score: \(HighScoreViewController.highScoreTable[level]![safe: index]?.score ?? 0)"
        }
    }

    // check if is highScore based on score and level and return the position
    static func checkHighScorePosition(_ score: Int, in level: SettingsViewController.DifficultyLevel) -> Int? {
        guard HighScoreViewController.highScoreTable[level] != nil else {
            return nil
        }

        // When score ladder is empty, just append and return top1
        if HighScoreViewController.highScoreTable[level]!.isEmpty {
            HighScoreViewController.highScoreTable[level]?.append(Player(name: "", score: score, date: Date()))
            return 1
        }
        // if you a find a `score in table < input score` insert input score at that pos, and check if size > 3 to remove last element
        if let position = HighScoreViewController.highScoreTable[level]!.firstIndex(where: { $0.score < score }) {
            HighScoreViewController.highScoreTable[level]!.insert(Player(name: "", score: score, date: Date()), at: position)
            if HighScoreViewController.highScoreTable[level]!.count > 3 {
                HighScoreViewController.highScoreTable[level]!.remove(at: HighScoreViewController.highScoreTable[level]!.endIndex-1) }
            return position + 1
        }
        // if there is not any `score in table < input score`, but table size < 3, append input score, return last index as position
        if HighScoreViewController.highScoreTable[level]!.count < 3 {
            HighScoreViewController.highScoreTable[level]!.append(Player(name: "", score: score, date: Date()))
            return HighScoreViewController.highScoreTable[level]!.endIndex
        }
        return nil
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
