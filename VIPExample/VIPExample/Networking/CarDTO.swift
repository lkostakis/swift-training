//
//  CarDTO.swift
//  VIPExample
//
//  Created by Christos Koninis on 3/15/23.
//

import Foundation

struct CarDTO: Codable {
    var model: String
    var imageURL: String
    var manufacturedDate: String
    var engineType: String
}

extension CarModel {

    enum CarError: Error {
        case invalidImageURL
        case invalidDateFormat
        case unknownEngineType
    }

    init(carDTO: CarDTO) throws {
        self.model = carDTO.model

        guard let imageURL = URL(string: carDTO.imageURL) else {
            throw CarError.invalidImageURL
        }
        self.imageURL = imageURL

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let manufacturedDate = dateFormatter.date(from: carDTO.manufacturedDate) else {
            throw CarError.invalidDateFormat
        }
        self.manufacturedDate = manufacturedDate

        guard let engineType = EngineType(rawValue: carDTO.engineType) else {
            throw CarError.unknownEngineType
        }
        self.engineType = engineType
    }
}
