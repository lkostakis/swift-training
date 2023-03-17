//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 7/2/23.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel! // maximum label based on difficulty level
    @IBOutlet weak var labelValue: UILabel!  // container title
    @IBOutlet weak var slider: UISlider! // helping var in order to set slider at 50
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    private lazy var totalScore: (total: Int, label: UILabel) = (0, scoreLabel)
    private lazy var roundCounter: (counter: Int, label: UILabel) = (0, roundLabel)
    private lazy var sliderValue = selectedLevel.rawValue // set sliderValue based on difficulty
    private var targetValue: Int = 0 // target value
    // calculate the scores for all levels in scale from 1 to 100
    private var computeScore: Int {
        get { (selectedLevel.rawValue - abs(Int(slider.value) - targetValue))*100/selectedLevel.rawValue }}
    private var selectedLevel = Settings.shared.currentLevel {
        didSet {
            if selectedLevel != oldValue {
                setUIElements()
                startNextRound()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // these things has to be initialized just once in whole app lifecycle
        Reader.shared.readFromMemory()
        title = "Bull's Eye"
        slider.minimumValue = 1
        navigationController?.navigationBar.backgroundColor = .systemGray6
        startListeningWhenDifficultyLevelChanged()
        setUIElements()
        startNextRound()
    }

    // here we set the labels and variables that
    // changes only when the level is changed and
    // not whenever a new round starts. So we dont
    // have to re-load the same things if not necessary.
    private final func setUIElements() {
        roundCounter.counter = 0
        totalScore.total = 0
        levelLabel.text = "Level: \(selectedLevel.toString())"
        slider.maximumValue = Float(selectedLevel.rawValue) // set slider's maximum value
        maxValueLabel.text = String(Int(slider.maximumValue))
    }

    private final func startNextRound() {
        slider.value = Float(selectedLevel.rawValue/2) // init the slider to the middle
        roundCounter.counter += 1 // to the next round..
        roundCounter.label.text = "Round: \(roundCounter.counter)"  // set text labels for round, score
        totalScore.label.text = "Score: \(totalScore.total)"
        targetValue = Int.random(in: 1...selectedLevel.rawValue) // set target value based on difficulty level
        labelValue.text = "Put the Bull's eye as close as you can to: \(targetValue)"
    }

    private final func startListeningWhenDifficultyLevelChanged() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeSelectedLevel(notification:)),
                                               name: NSNotification.Name.DifficultyLevelChanged,
                                               object: nil)
    }

    @objc func changeSelectedLevel(notification: Notification) {
        if let level = notification.userInfo?["level_changed"] as? Settings.DifficultyLevel {
            self.selectedLevel = level
        }
    }

    @IBAction func hitMeTapped(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Scoreboard",
            message: "Your score is: \(computeScore)",
            preferredStyle: .alert)

        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                self.totalScore.total += self.computeScore
                self.startNextRound()
            })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func startNewGame(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Start Over",
            message: "Are you sure you wanna start new game?",
            preferredStyle: .alert)

        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                if let place = HighScoreTable.shared.getHighScorePosition(self.totalScore.total, in: self.selectedLevel) {
                    self.showHighScoreModal(position: place)
                }
                self.roundCounter.counter = 0
                self.totalScore.total = 0
                self.startNextRound()
            })

        let cancelAction = UIAlertAction(
            title: "cancel",
            style: .destructive)

        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    private final func showHighScoreModal(position place: Int) {
        HighScoreTable.place = place
        HighScoreTable.score = totalScore.total
        present(HighScoreViewController(), animated: true, completion: nil)
    }

    @IBAction func adjustSlider(_ sender: UISlider) {
        sliderValue = Int(sender.value)
    }

}
