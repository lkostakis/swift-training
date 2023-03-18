//
//  OrderViewCell.swift
//  PizzaStore
//
//  Created by Lefteris Kostakis on 15/3/23.
//

import UIKit

class OrderViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    static let reuseIdentifier = "\(OrderViewCell.self)"

    func configure(name: String, order: String) {
        nameLabel.text = name
        orderLabel.text = order
    }
}
