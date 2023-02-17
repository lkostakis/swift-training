//
//  SettingsViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 15/2/23.
//

import UIKit

class SettingsViewController: UIViewController, ViewControllerData, UIPickerViewDelegate, UIPickerViewDataSource {
    var viewController: ViewController?
    var currentLevel: Int?
    private let difficultyRanges = [30, 100, 200, 300, 1000]
    private let pickerViewRows = ["I'm too young to die (1-30)", "Hey, not too rough (1-100)", "Hurt me plenty (1-200)", "Ultra-Violence (1-300)", "Nightmare! (1-1000)"]
    
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
    static let shared = SettingsViewController()
    private init() { }
    
    init(currentLevel level: Int, controller: ViewController) {
        self.currentLevel = level
        self.viewController = controller
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        // There is no chance that currentLevel is not contained in the array
        pickerView.selectRow(difficultyRanges.firstIndex(of: currentLevel ?? 1)!, inComponent: 0, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        changeLevel()
    }
    
    func changeLevel() {
        viewController?.selectedLevel.rawValue = difficultyRanges[pickerView.selectedRow(inComponent: 0)]
    }

}
