//
//  SettingsViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 15/2/23.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private var currentLevel = 0
    
    let pickerViewRows = ["I'm too young to die (1-30)", "Hey, not too rough (1-100)", "Hurt me plenty (1-200)", "Ultra-Violence (1-300)", "Nightmare!  (1-1000)"]
    
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
    
    init(currentLevel level: Int) {
        self.currentLevel = level
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(selectRow(currentLevel), inComponent: 0, animated: true)
        
    }

    func selectRow(_ level: Int) -> Int {
        switch currentLevel {
        case 30: return 0
        case 100: return 1
        case 200: return 2
        case 300: return 3
        default: return 4
        }
    }
    
}
