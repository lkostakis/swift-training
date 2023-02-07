//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 7/2/23.
//

import UIKit

@propertyWrapper
struct NumberZeroToTen {
    private var number: Float
    
    var wrappedValue: Float {
        get { number }
        set { number = min(max(newValue, 0), 10) }
    }
    
    init(wrappedValue: Float) {
        number = min(max(wrappedValue, 0), 10)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var sliderValue: UISlider!
    
    @NumberZeroToTen private var counter: Float = 0.0 {
        didSet {
            sliderValue.value = round(counter * 100) / 100
            roundCounter()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func plusOneButton(_ sender: UIButton) {
        counter += 1
    }
    
    @IBAction func minusOneButton(_ sender: UIButton) {
        counter -= 1
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        counter = 0
    }
    
    @IBAction func adjustSlider(_ sender: UISlider) {
        counter = sender.value
    }
    
    func roundCounter() {
        labelValue.text = String(round(counter * 100) / 100)
    }
    
}

