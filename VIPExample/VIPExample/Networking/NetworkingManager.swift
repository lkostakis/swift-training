//
//  NetworkingManager.swift
//  VIPExample
//
//  Created by Christos Koninis on 3/15/23.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()

    func performAPICall(completion: ([CarDTO]) -> Void) {
        // fake the API call by returning data from a file instead from the server

        let data = try! Data(contentsOf: Bundle.main.url(forResource: "APIResponse", withExtension: "json")!)
        let cars = try! JSONDecoder().decode([CarDTO].self, from: data)
        completion(cars)
    }
}
