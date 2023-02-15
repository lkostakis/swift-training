//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 7/2/23.
//

import UIKit

@propertyWrapper
struct LimitRange {
    private var number: Int
    var minValue: Int = 0
    var maxValue: Int = 100
    var wrappedValue: Int {
        get { number }
        set { number = min(max(newValue, minValue), maxValue) }
    }
    
    init(wrappedValue: Int, minValue: Int, maxValue: Int) {
        number = min(max(wrappedValue, minValue), maxValue)
        self.minValue = minValue
        self.maxValue = maxValue
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var slider: UISlider! // helping var in order to set slider at 50
    @LimitRange(minValue: 1, maxValue: 100) private var sliderValue: Int = 50
    private var targetValue: Int = 0
    private var computeScore: Int {
        get { 100 - abs(Int(slider.value) - targetValue) }
    }
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
        slider.value = 50 // init the slider to the middle
        roundCounter.counter += 1 // to the next round..
        roundCounter.label.text = "Round: \(roundCounter.counter)"
        totalScore.label.text = "Score: \(totalScore.total)"
        targetValue = Int.random(in: 1...100)
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
        print("tapped")
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
}

