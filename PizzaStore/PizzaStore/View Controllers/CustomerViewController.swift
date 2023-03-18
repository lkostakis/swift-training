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
    @IBOutlet weak var scrollView: UIScrollView!

//    private func startObservingKeyboardEvents() {
//        NotificationCenter.default.addObserver(self,
//                                               selector:Selector(("keyboardWillShow:")),
//                                               name:UIResponder.keyboardWillShowNotification,
//                                               object:nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector:Selector(("keyboardWillHide:")),
//                                               name:UIResponder.keyboardWillHideNotification,
//                                               object:nil)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOnTap))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.contentInset.bottom = 100
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

    @IBAction func pizzaNameDidEndOnExit(_ sender: UITextField) {
        self.becomeFirstResponder()
    }

    @IBAction func clientNameDidEndOnExit(_ sender: UITextField) {
        self.becomeFirstResponder()
    }

    @objc func dismissKeyboardOnTap() {
        nameTextField.resignFirstResponder()
        pizzaTextField.resignFirstResponder()
    }
}

extension CustomerViewController {
    private final func addPizzaOrder(pizza: Pizza) {
        NotificationCenter.default.post(name: NSNotification.Name.PizzaOrdered,
                                        object: self,
                                        userInfo: ["pizza_order": pizza])
    }
}

extension NSNotification.Name {
  static let PizzaOrdered = NSNotification.Name(rawValue: "pizza_order")
}
