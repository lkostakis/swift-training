//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 7/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    enum DifficultyLevel : Int {
        case easy = 30, medium = 100, hard = 200, veryHard = 300, ultraHard = 1000
    }
    private var selectedLevel = DifficultyLevel.medium.rawValue
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var slider: UISlider! // helping var in order to set slider at 50
    private lazy var sliderValue = selectedLevel
    private var targetValue: Int = 0
    private var computeScore: Int {
        get { (selectedLevel - abs(Int(slider.value) - targetValue))*100/selectedLevel }}
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    private lazy var totalScore: (total: Int, label: UILabel) = (0, scoreLabel)
    private lazy var roundCounter: (counter: Int, label: UILabel) = (0, roundLabel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bull's Eye"

        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.rightBarButtonItem
        = UIBarButtonItem(title: nil, image: UIImage(named: "znsNtvIconSettings"), target: self, action: #selector(settingsTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startNextRound()
    }
    
    func startNextRound() {
        maxValueLabel.text = String(selectedLevel)
        slider.maximumValue = Float(selectedLevel)
        slider.minimumValue = 1
        slider.value = Float(selectedLevel/2) // init the slider to the middle
        roundCounter.counter += 1 // to the next round..
        roundCounter.label.text = "Round: \(roundCounter.counter)"
        totalScore.label.text = "Score: \(totalScore.total)"
        targetValue = Int.random(in: 1...selectedLevel)
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
//        print(sliderValue)
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        let aboutViewController = AboutViewController()
        aboutViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    @objc func settingsTapped() {
        print("tapped")
        let settingsViewController = SettingsViewController(currentLevel: selectedLevel)
        settingsViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

}
