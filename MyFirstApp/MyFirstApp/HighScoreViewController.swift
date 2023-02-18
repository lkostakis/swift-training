//
//  HighScoreViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 17/2/23.
//

import UIKit

class HighScoreViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    static var highScoreTable: [SettingsViewController.DifficultyLevel : [Int]] = [SettingsViewController.DifficultyLevel.tooYoungToDie : [], SettingsViewController.DifficultyLevel.heyNotTooRough : [], SettingsViewController.DifficultyLevel.hurtMePlenty : [], SettingsViewController.DifficultyLevel.ultraViolence : [], SettingsViewController.DifficultyLevel.nightmare : [] ]
    private var place: Int = 0
    private var level: String = ViewController().selectedLevel.toString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // init HighScoreViewController instance in order to demonstrate the view
    init(position place: Int, difficulty level: String) {
        self.place = place
        self.level = level
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        message.text = "Congratulations you have achieved a top \(place) score in \(level) difficulty."
    }
    
    // check if is highScore based on score and level and return the position
    static func checkHighScorePosition(_ score: Int, in level: SettingsViewController.DifficultyLevel) -> Int? {
        let scoreInLevel = HighScoreViewController.highScoreTable[level]!
        
        
        return 0
    }
//    static func getHighScorePosition() -> Int? {
//        let score = ViewController.tempScore
//        // assuming whoever does a highscore first he wins in draw case
//        if let minValue = highScoreTable.min(), let place = highScoreTable.firstIndex(of: minValue), minValue < score {
//            print("min val: \(minValue)")
//            print("min index: \(place)")
//            if !highScoreTable.isEmpty {
//                if place != 0 {
//                    highScoreTable.insert(score, at: highScoreTable.index(before: place))
//                    if highScoreTable.count>3 { highScoreTable.remove(at: highScoreTable.endIndex) }
//                } else {
//                    let temp = highScoreTable[0]
//                    highScoreTable[0] = score
//                    highScoreTable.insert(temp, at: highScoreTable.index(after: 0))
//                    if highScoreTable.count>3 { highScoreTable.remove(at: highScoreTable.endIndex) }
//                }
//            } else {
//                print("hey")
//                highScoreTable[0] = score
//            }
//            highScoreTable.sort(by: { $0 > $1 })
//            print(highScoreTable)
//            return place
//        }
//        highScoreTable.sort(by: { $0 > $1 })
//        print(highScoreTable)
//        return nil
//    }

}
