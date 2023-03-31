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
    var interactor: HighScoresInteractor!
    var messageText: String? {
        didSet {
            messageLabel.text = messageText
        }
    }
    var topThreePlayersList: [HighScoresPresenter.PlayerModel]? {
        didSet {
            reloadTopScoreLabels()
        }
    }

    func reloadTopScoreLabels() {
        guard let topThreePlayersList else {
            return
        }

        zip([topScore1Label, topScore2Label, topScore3Label], topThreePlayersList).map {
            $0.text = $1.name + $1.score + $1.date
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter = HighScoresPresenter(controller: self)
        interactor = HighScoresInteractor(presenter: presenter)
        nameTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        messageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        messageLabel.text = messageText
        interactor.viewWillAppear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        interactor.addPlayerToTable(Player(
                                    name: nameTextField.text ?? "No name entered.",
                                    score: HighScoreTable.score, date: Date.now))
        interactor.viewDidDisappear()
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
