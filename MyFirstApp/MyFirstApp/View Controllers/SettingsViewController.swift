//
//  SettingsViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 15/2/23.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private lazy var difficultyArray = Settings.DifficultyLevel.allCases.map { $0.rawValue }
    private let pickerViewRows = Settings.DifficultyLevel.allCases.map { $0.toString() }

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        // There is no chance that currentLevel is not contained in the array
        pickerView.selectRow(difficultyArray.firstIndex(of: Settings.currentLevel ?? 1)!, inComponent: 0, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        changeLevel()
    }
    
    final func changeLevel() {
        // can safely use force-unwrap as pickerView already has data in component 0
        Settings.viewController?.selectedLevel = Settings.DifficultyLevel(rawValue: difficultyArray[pickerView.selectedRow(inComponent: 0)])!
    }

}
