//
//  HighScoreViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 17/2/23.
//

import UIKit

class HighScoreViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var topScore1: UILabel!
    @IBOutlet weak var topScore2: UILabel!
    @IBOutlet weak var topScore3: UILabel!
    private lazy var topScoreLabels = [topScore1, topScore2, topScore3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        message.font = UIFont.boldSystemFont(ofSize: 20)
        message.text = "Congratulations you have achieved a top \(HighScoreTable.place+1) score with \(HighScoreTable.score) in \(HighScoreTable.level.toString()) difficulty."
        
        for (index, player)in HighScoreTable.scoreTable[HighScoreTable.level]!.enumerated() {
            topScoreLabels[index]?.text = "\(index + 1). Score: \(player.score)\nName: \(player.name)\nDate: \(player.date.displayFormat)"
        }
        nameTextField.text = ""
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        HighScoreTable.shared.addPlayerToHighScoreTable(player: Player(name: nameTextField.text!, score: HighScoreTable.score, date: Date.now))
        Writer.writeToMemory()
        dismiss(animated: true)
    }
    
    @IBAction func didEndOnExit(_ sender: UITextField) {
        self.becomeFirstResponder()
    }

}
