//
//  TopScoresViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 20/2/23.
//

import UIKit

class TopScoresViewController: UIViewController {
    static let shared = TopScoresViewController()
    static var viewController: ChangedLevelDelegate?
    static var currentLevel: Int?
    
    @IBOutlet weak var top1Label: UILabel!
    @IBOutlet weak var top2Label: UILabel!
    @IBOutlet weak var top3Label: UILabel!
    
    private init() { super.init(nibName: nil, bundle: nil) }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let level = TopScoresViewController.viewController?.selectedLevel
        // viewController has already got instantiated
        let players = HighScoreViewController.highScoreTable[level!]!
        top1Label.text = "Name: \(players[0].name) Score: \(players[0].score) Date: \(players[0].date)"
        top2Label.text = "Name: \(players[1].name) Score: \(players[1].score) Date: \(players[1].date)"
        top3Label.text = "Name: \(players[2].name) Score: \(players[2].score) Date: \(players[2].date)"
    }

}
