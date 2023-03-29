//
//  HighScoresViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 27/3/23.
//

import UIKit

class HighScoresViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var topScore1Label: UILabel!
    @IBOutlet weak var topScore2Label: UILabel!
    @IBOutlet weak var topScore3Label: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    private lazy var topScoreLabels = [topScore1Label, topScore2Label, topScore3Label]
    var interactor: HighScoresInteractor!
    var messageText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap))
        view.addGestureRecognizer(tapGesture)
        interactor.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        messageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        messageLabel.text = messageText

        for (index, player) in HighScoreTable.scoreTable[Settings.shared.currentLevel]!.enumerated() {
            topScoreLabels[index]?.text =
            "\(index + 1). Score: \(player.score)\nName: \(player.name)\nDate: \(player.date.displayFormat)"
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        if nameTextField.text == "" {
            nameTextField.text = "No name entered."
        }

        HighScoreTable.shared.addPlayerToHighScoreTable(player: Player(name: nameTextField.text ?? "No name entered.",
                                                                       score: HighScoreTable.score, date: Date.now))
        highScoreTableChanged()
        Writer.shared.writeToMemory()
    }

    private final func highScoreTableChanged() {
        NotificationCenter.default.post(name: NSNotification.Name.HighScoreTableChanged,
                                        object: self,
                                        userInfo: ["highscore_changed": HighScoreTable.scoreTable])
    }

    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }

    @IBAction func didEndOnExit(_ sender: UITextField) {
        self.becomeFirstResponder()
    }

    @objc func dismissKeyboardOnTap() {
        nameTextField.resignFirstResponder()
    }
}
