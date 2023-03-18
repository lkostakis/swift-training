//
//  ViewController.swift
//  VIPExample
//
//  Created by Christos Koninis on 3/15/23.
//

import UIKit

// Create a CarListTableViewController that displays the same information as in the CarListViewController
// but uses a UITableview instead of a UIPickerView
class CarListTableViewController: UIViewController, CarListViewControllerProtocol {
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

class CarListViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,
                             CarListViewControllerProtocol {
    var interactor: CarListInteractor!

    var carList: [CarListPresenter.CarListViewModel]? {
        didSet {
            picker.reloadAllComponents()
        }
    }

    @IBOutlet weak var picker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter = CarListPresenter(controller: self)
        interactor = CarListInteractor(presenter: presenter)
        interactor.viewDidLoad()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        carList?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        interactor.didSelectCarAtIndex(row)
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let view = Bundle.main.loadNibNamed("CarListItemView", owner: nil, options: nil)?.first as? UIView else {
            print("Could not load CarListView")
            return UIView()
        }
        guard let carList else {
            print("The carList is empty")
            return UIView()
        }

        (view.viewWithTag(1) as? UILabel)?.text = carList[row].nameAndEngine
        (view.viewWithTag(2) as? UILabel)?.text = carList[row].manufacturedDateDate

        return view
    }
}
