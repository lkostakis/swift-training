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
        title = "About"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textViewDescription.text = "The objective of the game is to move a slider as close to a randomly chosen target"
        + "value as you can. Because you can’t see the current value of the slider, you’ll have to “eyeball” it."
        + "There are five different difficulty levels, each of which re-evaluates the slider's values in different"
        + "ranges starting from 1, such as [1, 30], [1, 100], etc."
    }

}
