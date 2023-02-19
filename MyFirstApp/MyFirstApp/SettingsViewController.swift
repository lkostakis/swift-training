//
//  SettingsViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 15/2/23.
//

import UIKit

class SettingsViewController: UIViewController, ViewControllerData, UIPickerViewDelegate, UIPickerViewDataSource {
    static let shared = SettingsViewController()
    
    enum DifficultyLevel : Int, CaseIterable {
        case tooYoungToDie = 30, heyNotTooRough = 100, hurtMePlenty = 200, ultraViolence = 300, nightmare = 1000

        // helping function to get string based on case
        func toString() -> String {
            switch self {
            case .tooYoungToDie: return "I'm too young to die (1-30)"
            case .heyNotTooRough: return "Hey, not too rough (1-100)"
            case .hurtMePlenty: return "Hurt me plenty (1-200)"
            case .ultraViolence: return "Ultra-Violence (1-300)"
            case .nightmare: return "Nightmare! (1-1000)"
            }
        }

    }
    
    var viewController: ViewController?
    var currentLevel: Int?
    private lazy var difficultyArray = DifficultyLevel.allCases.map { $0.rawValue }
    private let pickerViewRows = [DifficultyLevel.tooYoungToDie.toString(), DifficultyLevel.heyNotTooRough.toString(), DifficultyLevel.hurtMePlenty.toString(), DifficultyLevel.ultraViolence.toString(), DifficultyLevel.nightmare.toString()]
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerViewRows.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerViewRows[row]
    }
    @IBOutlet weak var pickerView: UIPickerView!

    private init() { super.init(nibName: nil, bundle: nil) }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        // There is no chance that currentLevel is not contained in the array
        pickerView.selectRow(difficultyArray.firstIndex(of: currentLevel ?? 1)!, inComponent: 0, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        changeLevel()
    }
    
    final func changeLevel() {
        // can safely use force-unwrap as pickerView already has data in component 0
        viewController?.selectedLevel = DifficultyLevel(rawValue: difficultyArray[pickerView.selectedRow(inComponent: 0)])!
    }

}
