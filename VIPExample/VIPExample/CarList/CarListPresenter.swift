//
//  CarListPresenter.swift
//  VIPExample
//
//  Created by Christos Koninis on 3/16/23.
//

import Foundation

protocol CarListViewControllerProtocol: AnyObject {
    var carList: [CarListPresenter.CarListViewModel]? {get set}
    func setLoadingIndicator(_ shouldDisplay: Bool)
}

final class CarListPresenter {
    struct CarListViewModel {
        let nameAndEngine: String
        let manufacturedDateDate: String
    }

    weak var controller: CarListViewControllerProtocol?

    init(controller: CarListViewControllerProtocol) {
        self.controller = controller
    }

    func displayLoaderIndicator(_ shouldDisplay: Bool) {
        controller?.setLoadingIndicator(shouldDisplay)
    }

    func displayCars(_ cars: [CarModel]) {
        // convert the domain model to user-facing data
        // here we have the logic that formatd the data
        // to be presented to the UI
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let viewModels = cars.map {
            let nameAndEngine = "\($0.model) - \($0.engineType)"
            let date = dateFormatter.string(from: $0.manufacturedDate)

            return CarListViewModel(nameAndEngine: nameAndEngine, manufacturedDateDate: date)
        }
        self.controller?.carList = viewModels

    }
}
