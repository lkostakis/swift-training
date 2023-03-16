//
//  ViewController.swift
//  PizzaStore
//
//  Created by Lefteris Kostakis on 15/3/23.
//

import UIKit

class PizzaStoreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var timer: Timer?
    private var pizzaStore = PizzaStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        startListeningForPizzaOrder()
        navigationController?.navigationBar.backgroundColor = .systemGray5
        title = "Pizza Store"
        navigationItem.rightBarButtonItem =
                UIBarButtonItem(
                    image: UIImage(systemName: "plus"),
                    style: .plain,
                    target: self,
                    action: #selector(addPizzaTapped))
        tableView.estimatedRowHeight = 300
        tableView.register(UINib(nibName: "\(OrderViewCell.self)", bundle: nil), forCellReuseIdentifier: OrderViewCell.reuseIdentifier)
        pizzaStore.startListeningWhenPizzaDelivered()
    }
    
    @objc func addPizzaTapped() {
        navigationController?.pushViewController(CustomerViewController(), animated: true)
    }

    func preparePizza(pizza: Pizza) {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
            print("Pizza is delivered to: \(pizza.clientName)")
            self.pizzaStore.orders.remove(at: self.pizzaStore.orders.endIndex - 1)
            self.tableView.reloadData()
            self.deliverPizza(pizza: pizza)
        }
    }
}

extension PizzaStoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pizzaStore.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as? OrderViewCell else {
            return UITableViewCell()
        }
        
        let name = pizzaStore.orders[indexPath.row].clientName
        let order = pizzaStore.orders[indexPath.row].pizzaName
        cell.configure(name: name, order: order)
        return cell
    }
}

extension PizzaStoreViewController {
    private final func startListeningForPizzaOrder() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addPizzaOrder(notification:)),
                                               name: NSNotification.Name.PizzaOrdered,
                                               object: nil)
    }
    
    @objc func addPizzaOrder(notification: Notification) {
        if let pizza = notification.userInfo?["pizza_order"] as? Pizza {
            pizzaStore.orders.append(pizza)
            tableView.reloadData()
            preparePizza(pizza: pizza)
        }
    }
    
    private final func deliverPizza(pizza: Pizza) {
        print("pizza to be delivered: \(pizza)")
        NotificationCenter.default.post(name: NSNotification.Name.PizzaOnReady,
                                        object: self,
                                        userInfo: ["pizza_ready" : pizza])
    }
    
}

extension NSNotification.Name {
    static let PizzaOnReady = NSNotification.Name(rawValue: "pizza_ready")
}
