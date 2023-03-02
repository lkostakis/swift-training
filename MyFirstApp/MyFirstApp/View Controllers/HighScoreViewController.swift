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

class HighScoreViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var topScore1: UILabel!
    @IBOutlet weak var topScore2: UILabel!
    @IBOutlet weak var topScore3: UILabel!
    private lazy var topScoreLabels = [topScore1, topScore2, topScore3]
    static var highScoreTable: [SettingsViewController.DifficultyLevel : [Player] ] = [SettingsViewController.DifficultyLevel.tooYoungToDie : [], SettingsViewController.DifficultyLevel.heyNotTooRough : [], SettingsViewController.DifficultyLevel.hurtMePlenty : [], SettingsViewController.DifficultyLevel.ultraViolence : [], SettingsViewController.DifficultyLevel.nightmare : [] ]
    static let shared = HighScoreViewController()
    static var place: Int = 0
    static var level: SettingsViewController.DifficultyLevel = ViewController().selectedLevel
    var name: String?
    static var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }
    
    private init() { super.init(nibName: nil, bundle: nil) }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        message.font = UIFont.boldSystemFont(ofSize: 20)
        message.text = "Congratulations you have achieved a top \(HighScoreViewController.place+1) score with \(HighScoreViewController.score) in \(HighScoreViewController.level.toString()) difficulty."
        
        for (index, player)in HighScoreViewController.highScoreTable[HighScoreViewController.level]!.enumerated() {
            topScoreLabels[index]?.text = "\(index + 1). Score: \(player.score) Date: \(player.date)"
        }
        nameTextField.text = ""
    }

    // check if is highScore based on score and level and return the position
    static func checkHighScorePosition(_ score: Int, in level: SettingsViewController.DifficultyLevel) -> Int? {
        guard HighScoreViewController.highScoreTable[level] != nil else {
            return nil
        }

        // When score ladder is empty, just return top1
        if HighScoreViewController.highScoreTable[level]!.isEmpty {
            return 0
        }
        // if you a find a `score in table < input score` return that index
        if let position = HighScoreViewController.highScoreTable[level]!.firstIndex(where: { $0.score < score }) {
            return position
        }
        // if there is not any `score in table < input score`, but table size < 3, return last index as position
        if HighScoreViewController.highScoreTable[level]!.count < 3 {
            return HighScoreViewController.highScoreTable[level]!.endIndex
        }
        return nil
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        addPlayerToHighScoreTable()
        // Writer.writeToMemory()
        dismiss(animated: true)
    }
    
    func addPlayerToHighScoreTable() {
        let player = Player(name: nameTextField.text!, score: HighScoreViewController.score, date: Date.now)
        if HighScoreViewController.highScoreTable[HighScoreViewController.level]!.isEmpty {
            HighScoreViewController.highScoreTable[HighScoreViewController.level]!.append(player)
        } else if HighScoreViewController.highScoreTable[HighScoreViewController.level]!.count <= 3 {
            HighScoreViewController.highScoreTable[HighScoreViewController.level]!.insert(player, at: HighScoreViewController.place)
        }
        if HighScoreViewController.highScoreTable[HighScoreViewController.level]!.count > 3 {
            HighScoreViewController.highScoreTable[HighScoreViewController.level]!.remove(at: HighScoreViewController.highScoreTable[HighScoreViewController.level]!.endIndex-1)
        }
    }
    
    @IBAction func edittingChanged(_ sender: UITextField) {
        print("textValueChanged text: \(sender.text)")
    }
    
    @IBAction func didEndOnExit(_ sender: UITextField) {
        self.becomeFirstResponder()
    }
    
    @IBAction func editingDidEnd(_ sender: UITextField) {

    }

}
