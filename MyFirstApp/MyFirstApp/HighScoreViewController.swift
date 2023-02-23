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

class HighScoreViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var topScore1: UILabel!
    @IBOutlet weak var topScore2: UILabel!
    @IBOutlet weak var topScore3: UILabel!
    private(set) static var highScoreTable: [SettingsViewController.DifficultyLevel : [Player] ] = [SettingsViewController.DifficultyLevel.tooYoungToDie : [], SettingsViewController.DifficultyLevel.heyNotTooRough : [], SettingsViewController.DifficultyLevel.hurtMePlenty : [], SettingsViewController.DifficultyLevel.ultraViolence : [], SettingsViewController.DifficultyLevel.nightmare : [] ]
    static let shared = HighScoreViewController()
    static var place: Int = 0
    static var level: SettingsViewController.DifficultyLevel = ViewController().selectedLevel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private init() { super.init(nibName: nil, bundle: nil) }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        message.font = UIFont.boldSystemFont(ofSize: 20)
        message.text = "Congratulations you have achieved a top \(HighScoreViewController.place) score in \(HighScoreViewController.level.toString()) difficulty."
        [topScore1, topScore2, topScore3].enumerated().forEach { (index, label) in
            label!.text = "\(index + 1). Score: \(HighScoreViewController.highScoreTable[HighScoreViewController.level]![safe: index]?.score ?? 0) Date: \(String(describing: HighScoreViewController.highScoreTable[HighScoreViewController.level]![safe: index]?.date ?? nil))"
        }
    }

    // check if is highScore based on score and level and return the position
    static func checkHighScorePosition(_ score: Int, in level: SettingsViewController.DifficultyLevel) -> Int? {
        guard HighScoreViewController.highScoreTable[level] != nil else {
            return nil
        }

        // When score ladder is empty, just append and return top1
        if HighScoreViewController.highScoreTable[level]!.isEmpty {
            HighScoreViewController.highScoreTable[level]?.append(Player(name: getName(), score: score, date: Date.now))
            return 1
        }
        // if you a find a `score in table < input score` insert input score at that pos, and check if size > 3 to remove last element
        if let position = HighScoreViewController.highScoreTable[level]!.firstIndex(where: { $0.score < score }) {
            HighScoreViewController.highScoreTable[level]!.insert(Player(name: getName(), score: score, date: Date.now), at: position)
            if HighScoreViewController.highScoreTable[level]!.count > 3 {
                HighScoreViewController.highScoreTable[level]!.remove(at: HighScoreViewController.highScoreTable[level]!.endIndex-1) }
            return position + 1
        }
        // if there is not any `score in table < input score`, but table size < 3, append input score, return last index as position
        if HighScoreViewController.highScoreTable[level]!.count < 3 {
            HighScoreViewController.highScoreTable[level]!.append(Player(name: getName(), score: score, date: Date.now))
            return HighScoreViewController.highScoreTable[level]!.endIndex
        }
        return nil
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func edittingChanged(_ sender: UITextField) {
        print("textValueChanged text: \(sender.text)")
    }

    static func getName() -> String {
        return ""
    }

}
