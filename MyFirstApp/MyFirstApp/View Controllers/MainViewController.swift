//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 7/2/23.
//

import UIKit

class MainViewController: UIViewController, ChangedLevelDelegate {
    // default level is 1-100 "hey not too rough"
    // also if the difficulty level is not changed
    // remember the score and round counters
    // but if user changes the difficulty level then
    // re-init score and round counters to zero, etc.
    // so here we place only the things that are change
    // when difficulty level changes.
    var selectedLevel = Settings.DifficultyLevel.heyNotTooRough {
        didSet {
            if selectedLevel != oldValue {
                self.roundCounter.counter = 0
                self.totalScore.total = 0
                self.startNextRound()
            }
        }
    }

    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel! // maximum label based on difficulty level
    @IBOutlet weak var labelValue: UILabel!  // container title
    @IBOutlet weak var slider: UISlider! // helping var in order to set slider at 50
    private lazy var sliderValue = selectedLevel.rawValue // set sliderValue based on difficulty
    private var targetValue: Int = 0 // target value
    // calculate the scores for all levels in scale from 1 to 100
    private var computeScore: Int {
        get { (selectedLevel.rawValue - abs(Int(slider.value) - targetValue))*100/selectedLevel.rawValue }}
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    private lazy var totalScore: (total: Int, label: UILabel) = (0, scoreLabel)
    private lazy var roundCounter: (counter: Int, label: UILabel) = (0, roundLabel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // these things has to be initialized just once in whole app lifecycle
        Reader.readFromMemory()
        title = "Bull's Eye"
        slider.minimumValue = 1
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            image: UIImage(named: "znsNtvIconSettings"),
            style: .plain,
            target: self,
            action: #selector(settingsTapped))

        startNextRound()
    }

    private final func startNextRound() {
        topScoresButton() // create or not Crown button
        levelLabel.text = "Level: \(selectedLevel.toString())"
        slider.maximumValue = Float(selectedLevel.rawValue) // set slider's maximum value
        maxValueLabel.text = String(Int(slider.maximumValue))
        slider.value = Float(selectedLevel.rawValue/2) // init the slider to the middle
        roundCounter.counter += 1 // to the next round..
        roundCounter.label.text = "Round: \(roundCounter.counter)"  // set text labels for round, score
        totalScore.label.text = "Score: \(totalScore.total)"
        targetValue = Int.random(in: 1...selectedLevel.rawValue) // set target value based on difficulty level
        labelValue.text = "Put the Bull's eye as close as you can to: \(targetValue)"
    }
    
    // topScoresButton() and createCrownButton() are a workaround because isHidden is not available on <iOS16
    func topScoresButton() {
        if HighScoreTable.scoreTable[selectedLevel]!.count >= 3 {
            createCrownButton()
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    func createCrownButton() {
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(
            image: UIImage(systemName: "crown"),
            style: .plain,
            target: self,
            action: #selector(scoreTableTapped))
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
                if let place = HighScoreTable.checkHighScorePosition(self.totalScore.total, in: self.selectedLevel) {
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

    func showHighScoreModal(position place: Int) {
        HighScoreTable.place = place
        HighScoreTable.level = selectedLevel
        HighScoreTable.score = totalScore.total
        present(HighScoreViewController(), animated: true, completion: nil)
    }

    @IBAction func adjustSlider(_ sender: UISlider) {
        sliderValue = Int(sender.value)
    }

    @IBAction func infoButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(AboutViewController(), animated: true)
    }

    @objc func settingsTapped() {
        Settings.currentLevel = selectedLevel.rawValue
        Settings.viewController = self
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc func scoreTableTapped() {
        Settings.currentLevel = selectedLevel.rawValue
        Settings.viewController = self
        navigationController?.pushViewController(TopScoresViewController(), animated: true)
    }

}
