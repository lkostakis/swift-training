//
//  TopScoresViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 20/2/23.
//

import UIKit

class TopScoresViewController: UIViewController {
//    static var viewController: ChangedLevelDelegate?
//    static var currentLevel: Int?
    
    @IBOutlet weak var top1Label: UILabel!
    @IBOutlet weak var top2Label: UILabel!
    @IBOutlet weak var top3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let level = Settings.viewController?.selectedLevel
        if let players = HighScoreTable.scoreTable[level!] {
            [top1Label, top2Label, top3Label].enumerated().forEach { (index, label) in
                label.text = "Name: \(players[index].name)\nScore: \(players[index].score)\nDate: \(players[index].date.displayFormat)" }
        }
    }

}
