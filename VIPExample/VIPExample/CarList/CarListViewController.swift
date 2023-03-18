//
//  ViewController.swift
//  VIPExample
//
//  Created by Christos Koninis on 3/15/23.
//

import UIKit

// Create a CarListTableViewController that displays the same information as in the CarListViewController
// but uses a UITableview instead of a UIPickerView
class CarListTableViewController: UIViewController {
    var interactor: CarListInteractor!
    @IBOutlet var tableView: UITableView!

    var carList: [CarListPresenter.CarListViewModel]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "\(CarListCell.self)", bundle: nil),
                           forCellReuseIdentifier: CarListCell.reuseIdentifier)
        let presenter = CarListPresenter(controller: self)
        interactor = CarListInteractor(presenter: presenter)
        interactor.viewDidLoad()
    }
}

extension CarListTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        carList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CarListCell.self)",
                                                       for: indexPath) as? CarListCell else {
            return UITableViewCell()
        }

        guard let car = carList?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(model: car.nameAndEngine, date: car.manufacturedDateDate)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didSelectCarAtIndex(indexPath.row)
    }
}
