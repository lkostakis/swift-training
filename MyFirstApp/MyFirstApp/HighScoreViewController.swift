//
//  HighScoreViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 17/2/23.
//

import UIKit

class HighScoreViewController: UIViewController {
    static let shared = HighScoreViewController()
    @IBOutlet weak var message: UILabel!
    private static var highScoreTable: [SettingsViewController.DifficultyLevel : [Int]] = [SettingsViewController.DifficultyLevel.tooYoungToDie : [], SettingsViewController.DifficultyLevel.heyNotTooRough : [], SettingsViewController.DifficultyLevel.hurtMePlenty : [], SettingsViewController.DifficultyLevel.ultraViolence : [], SettingsViewController.DifficultyLevel.nightmare : [] ]
    var place: Int = 0
    var level: String = ViewController().selectedLevel.toString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private init() { super.init(nibName: nil, bundle: nil) }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        message.font = UIFont.boldSystemFont(ofSize: 20)
        message.text = "Congratulations you have achieved a top \(place) score in \(level) difficulty."
    }
    
    // check if is highScore based on score and level and return the position
    static func checkHighScorePosition(_ score: Int, in level: SettingsViewController.DifficultyLevel) -> Int? {
        guard HighScoreViewController.highScoreTable[level] != nil else {
            return nil
        }
        
        if HighScoreViewController.highScoreTable[level]!.isEmpty {
            HighScoreViewController.highScoreTable[level]!.insert(score, at: HighScoreViewController.highScoreTable[level]!.startIndex)
            return 1
        }
        
        let boolArray = HighScoreViewController.highScoreTable[level]!.map { $0 < score }
        if let index = boolArray.firstIndex(where: { $0 == true }) {
            HighScoreViewController.highScoreTable[level]!.insert(score, at: index)
            if HighScoreViewController.highScoreTable[level]!.count > 3 {
                HighScoreViewController.highScoreTable[level]!.remove(at: HighScoreViewController.highScoreTable[level]!.endIndex-1)
            }
            HighScoreViewController.highScoreTable[level]!.sort(by: { $0 > $1 })
            return index+1
        } else {
            if HighScoreViewController.highScoreTable[level]!.count < 3 {
                HighScoreViewController.highScoreTable[level]!.insert(score, at: HighScoreViewController.highScoreTable[level]!.endIndex-1)
                HighScoreViewController.highScoreTable[level]!.sort(by: { $0 > $1 })
                return HighScoreViewController.highScoreTable[level]!.endIndex
            }
        }
        return nil
    }

}
