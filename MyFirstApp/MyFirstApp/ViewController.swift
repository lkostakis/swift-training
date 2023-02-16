//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 7/2/23.
//

import UIKit

protocol ViewControllerData {
    var viewController: ViewController? { get set }
    func changeLevel()
}

class ViewController: UIViewController {
    
    enum DifficultyLevel : Int {
        case tooYoungToDie = 30, heyNotTooRough = 100, hurtMePlenty = 200, ultraViolence = 300, nightmare = 1000
        
        static func toString(_ selectedLevel: Int) -> String {
            switch selectedLevel {
            case tooYoungToDie.rawValue: return "I'm too young to die (1-30)"
            case heyNotTooRough.rawValue: return "Hey, not too rough (1-100)"
            case hurtMePlenty.rawValue: return "Hurt me plenty (1-200)"
            case ultraViolence.rawValue: return "Ultra-Violence (1-300)"
            default: return "Nightmare! (1-1000)"
            }
        }
    }
    // default level is 1-100 "hey not too rough"
    // also if the difficulty level is not changed
    // remember the score and round counters
    // but if user changes the difficulty level then
    // re-init score and round counters to zero, etc.
    // so here we place only the things that are change
    // when difficulty level changes.
    var selectedLevel = DifficultyLevel.heyNotTooRough.rawValue {
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
    private lazy var sliderValue = selectedLevel // set sliderValue based on difficulty
    private var targetValue: Int = 0 // target value
    // calculate the scores for all levels in scale from 1 to 100
    private var computeScore: Int {
        get { (selectedLevel - abs(Int(slider.value) - targetValue))*100/selectedLevel }}
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    private lazy var totalScore: (total: Int, label: UILabel) = (0, scoreLabel)
    private lazy var roundCounter: (counter: Int, label: UILabel) = (0, roundLabel)

    override func viewDidLoad() {
        super.viewDidLoad()
        // these things has to be initialized just once in whole app lifecycle
        title = "Bull's Eye"
        slider.minimumValue = 1
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.rightBarButtonItem
        = UIBarButtonItem(title: nil, image: UIImage(named: "znsNtvIconSettings"), target: self, action: #selector(settingsTapped))
        startNextRound()
    }

    private final func startNextRound() {
        levelLabel.text = "Level: \(DifficultyLevel.toString(selectedLevel))"
        slider.maximumValue = Float(selectedLevel) // set slider's maximum value
        maxValueLabel.text = String(Int(slider.maximumValue))
        slider.value = Float(selectedLevel/2) // init the slider to the middle
        roundCounter.counter += 1 // to the next round..
        roundCounter.label.text = "Round: \(roundCounter.counter)"  // set text labels for round, score
        totalScore.label.text = "Score: \(totalScore.total)"
        targetValue = Int.random(in: 1...selectedLevel) // set target value based on difficulty level
        labelValue.text = "Put the Bull's eye as close as you can to: \(targetValue)"
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
    
    @IBAction func adjustSlider(_ sender: UISlider) {
        sliderValue = Int(sender.value)
    }

    @IBAction func infoButtonTapped(_ sender: UIButton) {
        let aboutViewController = AboutViewController()
        aboutViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    @objc func settingsTapped() {
        let settingsViewController = SettingsViewController(currentLevel: selectedLevel, controller: self)
        settingsViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

}
