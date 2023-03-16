//
//  CustomerViewController.swift
//  PizzaStore
//
//  Created by Lefteris Kostakis on 15/3/23.
//

import UIKit

class CustomerViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pizzaTextField: UITextField!
    @IBOutlet weak var addPizzaButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = nil
        pizzaTextField.text = nil
    }

    @IBAction func addPizzaTapped(_ sender: UIButton) {
        print("Button Tapped")
        guard let pizzaName = pizzaTextField.text, let clientName = nameTextField.text else {
            return
        }

        if pizzaName != "" && clientName != "" {
            let pizzaObj = Pizza(pizzaName: pizzaName, clientName: clientName)
            addPizzaOrder(pizza: pizzaObj)
            navigationController?.popViewController(animated: true)
        }
    }
}


extension CustomerViewController {
    private final func addPizzaOrder(pizza: Pizza) {
        NotificationCenter.default.post(name: NSNotification.Name.PizzaOrdered,
                                        object: self,
                                        userInfo: ["pizza_order" : pizza])
    }
    
//    private final func startListeningWhenPizzaDelivered() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(pizzaDelivered(notification:)),
//                                               name: NSNotification.Name.PizzaOnReady,
//                                               object: nil)
//    }
//
//    @objc func pizzaDelivered(notification: Notification) {
//        if let pizza = notification.userInfo?["pizza_ready"] as? Pizza {
//            print("yummy pizza \(pizza.pizzaName)")
//        }
//    }
    
}

extension NSNotification.Name {
  static let PizzaOrdered = NSNotification.Name(rawValue: "pizza_order")
}
