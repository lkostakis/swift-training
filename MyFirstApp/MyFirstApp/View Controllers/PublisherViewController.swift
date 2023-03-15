//
//  PublisherViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 10/3/23.
//

import UIKit

class PublisherViewController: UIViewController {

    private static var colorSelected: UIColor = .white
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var mintButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Publisher"
    }
    
    @IBAction func blueButtonTapped(_ sender: UIButton) {
        PublisherViewController.colorSelected = .systemBlue
        colorSelected()
    }

    @IBAction func orangeButtonTapped(_ sender: UIButton) {
        PublisherViewController.colorSelected = .systemOrange
        colorSelected()
    }
    
    @IBAction func tintButtonTapped(_ sender: UIButton) {
        PublisherViewController.colorSelected = .systemTeal
        colorSelected()
    }
    
    @IBAction func yellowButtonTapped(_ sender: UIButton) {
        PublisherViewController.colorSelected = .systemYellow
        colorSelected()
    }

    private final func colorSelected() {
        onColorSelected(color: PublisherViewController.colorSelected)
    }

    private final func onColorSelected(color: UIColor) {
        NotificationCenter.default.post(name: NSNotification.Name.ColorSelected,
                                        object: self,
                                        userInfo: ["color_selected" : color])
    }

}
