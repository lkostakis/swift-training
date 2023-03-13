//
//  SubscriberViewController.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 10/3/23.
//

import UIKit

class SubscriberViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startListeningWhenColorSelected()
    }
    
    private final func startListeningWhenColorSelected() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(colorSelected(notification:)),
                                               name: NSNotification.Name.ColorSelected,
                                               object: nil)
    }

    @objc func colorSelected(notification: Notification) {
        if let color = notification.userInfo?["color_selected"] as? UIColor {
            self.view.backgroundColor = color
        }
    }

    private final func stopListeningWhenColorSelected() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.ColorSelected,
                                                  object: nil)
    }

}
