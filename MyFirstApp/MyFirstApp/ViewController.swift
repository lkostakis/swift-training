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
        
        func toString2() -> String {
            switch self {
            case .tooYoungToDie: return "I'm too young to die (1-30)"
            case .heyNotTooRough: return "Hey, not too rough (1-100)"
            case .hurtMePlenty: return "Hurt me plenty (1-200)"
            case .ultraViolence: return "Ultra-Violence (1-300)"
            case .nightmare: return "Nightmare! (1-1000)"
            }
        }
//        static func toString(_ selectedLevel: Int) -> String {
//            switch selectedLevel {
//            case tooYoungToDie.rawValue: return "I'm too young to die (1-30)"
//            case heyNotTooRough.rawValue: return "Hey, not too rough (1-100)"
//            case hurtMePlenty.rawValue: return "Hurt me plenty (1-200)"
//            case ultraViolence.rawValue: return "Ultra-Violence (1-300)"
//            case nightmare.rawValue: return "Nightmare! (1-1000)"
//            default: return ""
//            }
//        }
    }
    // default level is 1-100 "hey not too rough"
    // also if the difficulty level is not changed
    // remember the score and round counters
    // but if user changes the difficulty level then
    // re-init score and round counters to zero, etc.
    // so here we place only the things that are change
    // when difficulty level changes.
    var selectedLevel: DifficultyLevel = DifficultyLevel.heyNotTooRough {
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
    private var highScoreTable: [Int] = [0]
    
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
        levelLabel.text = "Level: \(selectedLevel.toString2())"
        slider.maximumValue = Float(selectedLevel.rawValue) // set slider's maximum value
        maxValueLabel.text = String(Int(slider.maximumValue))
        slider.value = Float(selectedLevel.rawValue/2) // init the slider to the middle
        roundCounter.counter += 1 // to the next round..
        roundCounter.label.text = "Round: \(roundCounter.counter)"  // set text labels for round, score
        totalScore.label.text = "Score: \(totalScore.total)"
        targetValue = Int.random(in: 1...selectedLevel.rawValue) // set target value based on difficulty level
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
                self.checkForHighScore()
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
    
    func checkForHighScore() {
        // assuming whoever does a highscore first he wins in draw case
        if let minValue = highScoreTable.min(), let place = highScoreTable.firstIndex(of: minValue), minValue < totalScore.total {
            print("min val: \(minValue)")
            print("min index: \(place)")
            if !highScoreTable.isEmpty {
                if place != 0 {
                    highScoreTable.insert(totalScore.total, at: highScoreTable.index(before: place))
                    if highScoreTable.count>3 { highScoreTable.remove(at: highScoreTable.endIndex) }
                } else {
                    var temp = highScoreTable[0]
                    highScoreTable[0] = totalScore.total
                    highScoreTable.insert(temp, at: highScoreTable.index(after: 0))
                    if highScoreTable.count>3 { highScoreTable.remove(at: highScoreTable.endIndex) }
                }
            } else {
                print("hey")
                highScoreTable[0] = totalScore.total
            }
            
            showHighScoreModal(position: place+1)
        }
        highScoreTable.sort(by: { $0 > $1 })
        print(highScoreTable)
    }
    
    func showHighScoreModal(position place: Int) {
        print(place)
        let highScoreViewController = HighScoreViewController(position: place, difficulty: selectedLevel.toString2())
//        highScoreViewController.modalPresentationStyle = .none
        navigationController?.pushViewController(highScoreViewController, animated: true)
    }
    
    @IBAction func adjustSlider(_ sender: UISlider) {
        sliderValue = Int(sender.value)
    }

    @IBAction func infoButtonTapped(_ sender: UIButton) {
        let aboutViewController = AboutViewController()
        navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    @objc func settingsTapped() {
//        let settingsViewController = SettingsViewController(currentLevel: selectedLevel.rawValue, controller: self)
        SettingsViewController.shared.currentLevel = selectedLevel.rawValue
        SettingsViewController.shared.viewController = self
        navigationController?.pushViewController(SettingsViewController.shared, animated: true)
    }

}
