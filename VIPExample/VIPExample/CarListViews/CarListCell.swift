//
//  CarListCell.swift
//  VIPExample
//
//  Created by Lefteris Kostakis on 17/3/23.
//

import UIKit

class CarListCell: UITableViewCell {
    static let reuseIdentifier = "\(CarListCell.self)"
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configure(model: String, date: String) {
        modelLabel.text = model
        dateLabel.text = date
    }
}
