//
//  CarListInteractor.swift
//  VIPExample
//
//  Created by Christos Koninis on 3/16/23.
//

import Foundation
import UIKit

final class CarListInteractor {
    private var presenter: CarListPresenter
    private let repository: CarModelRepository
    private var carModels: [CarModel]?

    init(presenter: CarListPresenter, carRepository: CarModelRepository = CarModelRepository()) {
        self.presenter = presenter
        self.repository = carRepository
    }

    func viewDidLoad() {
        self.presenter.displayLoaderIndicator(true)
        repository.fetchCars { carModels in
            self.carModels = carModels
            self.presenter.displayLoaderIndicator(false)
            self.presenter.displayCars(carModels)
        }
    }

    func didSelectCarAtIndex(_ index: Int) {
        guard let carModels else {
            print("Car Models are not set")
            return
        }
        print("did select car \(carModels[index].model)")
    }
}
