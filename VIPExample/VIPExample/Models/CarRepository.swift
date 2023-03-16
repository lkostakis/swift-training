//
//  NetworkingManager.swift
//  VIPExample
//
//  Created by Christos Koninis on 3/15/23.
//

import Foundation

final class CarModelRepository {
    private var networking: NetworkingManager

    init(networking: NetworkingManager = NetworkingManager.shared) {
        self.networking = networking
    }

    func fetchCars(completion: ([CarModel]) -> Void) {
        self.networking.performAPICall { carDTOs in
            // convert the response from the Server to Domain Models

            let carModels = carDTOs.compactMap {try? CarModel(carDTO:$0)}
            completion(carModels)
        }
    }
}
