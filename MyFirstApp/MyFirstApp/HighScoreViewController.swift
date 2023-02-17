//
//  HighScoreViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 17/2/23.
//

import UIKit

class HighScoreViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    private var place: Int = 0
    private var level: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    init(position place: Int, difficulty level: String) {
        self.place = place
        self.level = level
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        message.text = "Congratulations you have achieved a top \(place) score in \(level) difficulty."
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
