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
        title = "Settings"

        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(1, inComponent: 0, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        difficultyLevelChanged()
    }
}

extension SettingsViewController {
    private final func difficultyLevelChanged() {
        NotificationCenter.default.post(name: NSNotification.Name.DifficultyLevelChanged,
                                        object: self,
                                        userInfo: ["level_changed": Settings.DifficultyLevel(rawValue:
                                                difficultyArray[pickerView.selectedRow(inComponent: 0)])
                                                ?? Settings.DifficultyLevel.heyNotTooRough])
    }
}
