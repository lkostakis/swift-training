//
//  AboutViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 10/2/23.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var textViewDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textViewDescription.text = "The objective of the game is to move the slider as close to a randomly chosen target value as you can. In the screenshot, the aim is to put the bull’s eye at 62. Because you can’t see the current value of the slider, you’ll have to “eyeball” it."
    }
    
}
