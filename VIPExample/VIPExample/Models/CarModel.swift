//
//  CarModel.swift
//  VIPExample
//
//  Created by Christos Koninis on 3/15/23.
//

import Foundation

enum EngineType: String {
    case petrol, gas, hybrid
}

struct CarModel {
    var model: String
    var imageURL: URL
    var manufacturedDate: Date
    var engineType: EngineType
}
