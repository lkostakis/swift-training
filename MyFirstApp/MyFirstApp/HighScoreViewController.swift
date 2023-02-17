//
//  HighScoreViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 17/2/23.
//

import UIKit

class HighScoreViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    private static var highScoreTable: [Int] = [0]
    var place: Int = 0
    lazy var level: String = SettingsViewController.DifficultyLevel.getCaseFromInt(difficulty: SettingsViewController.shared.currentLevel!).toString()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    init(position place: Int, difficulty level: String) {
//        self.place = place
//        self.level = level
//        super.init(nibName: nil, bundle: nil)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        message.text = "Congratulations you have achieved a top \(place) score in \(level) difficulty."
    }
    
    static func ifHighScore() -> Bool {
        let score = ViewController.tempScore
        // assuming whoever does a highscore first he wins in draw case
        if let minValue = highScoreTable.min(), let place = highScoreTable.firstIndex(of: minValue), minValue < score {
            print("min val: \(minValue)")
            print("min index: \(place)")
            if !highScoreTable.isEmpty {
                if place != 0 {
                    highScoreTable.insert(score, at: highScoreTable.index(before: place))
                    if highScoreTable.count>3 { highScoreTable.remove(at: highScoreTable.endIndex) }
                } else {
                    var temp = highScoreTable[0]
                    highScoreTable[0] = score
                    highScoreTable.insert(temp, at: highScoreTable.index(after: 0))
                    if highScoreTable.count>3 { highScoreTable.remove(at: highScoreTable.endIndex) }
                }
            } else {
                print("hey")
                highScoreTable[0] = score
            }

            return true
        }
        highScoreTable.sort(by: { $0 > $1 })
        return false
    }

}
