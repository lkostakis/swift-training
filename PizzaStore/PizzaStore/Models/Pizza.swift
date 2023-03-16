//
//  Pizza.swift
//  PizzaStore
//
//  Created by Lefteris Kostakis on 15/3/23.
//

import Foundation

class Pizza {
    var pizzaName: String
    var clientName: String
    
    init(pizzaName: String, clientName: String) {
        self.pizzaName = pizzaName
        self.clientName = clientName
    }
}

class PizzaStore {
    var orders: [Pizza] = []

    final func startListeningWhenPizzaDelivered() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(pizzaDelivered(notification:)),
                                               name: NSNotification.Name.PizzaOnReady,
                                               object: nil)
    }
    
    @objc func pizzaDelivered(notification: Notification) {
        if let pizza = notification.userInfo?["pizza_ready"] as? Pizza {
            print("yummy pizza \(pizza.pizzaName)")
        }
    }
    func orderPizza(pizza: Pizza) {
        
    }
    
    func deliver(pizza: Pizza) {
        
    }
}
