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
    static let shared = HighScoreViewController()
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var topScore1: UILabel!
    @IBOutlet weak var topScore2: UILabel!
    @IBOutlet weak var topScore3: UILabel!
    private static var highScoreTable: [SettingsViewController.DifficultyLevel : [Int]] = [SettingsViewController.DifficultyLevel.tooYoungToDie : [], SettingsViewController.DifficultyLevel.heyNotTooRough : [], SettingsViewController.DifficultyLevel.hurtMePlenty : [], SettingsViewController.DifficultyLevel.ultraViolence : [], SettingsViewController.DifficultyLevel.nightmare : [] ]
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
            label!.text = "\(index + 1). Score: \(HighScoreViewController.highScoreTable[level]?[safe: index] ?? 0)" }
    }

    // check if is highScore based on score and level and return the position
    static func checkHighScorePosition(_ score: Int, in level: SettingsViewController.DifficultyLevel) -> Int? {
        guard HighScoreViewController.highScoreTable[level] != nil else {
            return nil
        }
        // we used guard so we are surewe can use force-unwrap
        HighScoreViewController.highScoreTable[level]!.append(score)
        HighScoreViewController.highScoreTable[level]!.sort(by: { $0 > $1 })
        if HighScoreViewController.highScoreTable[level]!.count > 3 {
            HighScoreViewController.highScoreTable[level]!.remove(at: HighScoreViewController.highScoreTable[level]!.endIndex-1)
        }
        if let position = HighScoreViewController.highScoreTable[level]!.firstIndex(of: score) {
            return position+1
        }
        return nil
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
