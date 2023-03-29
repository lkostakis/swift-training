//
//  CarModelTests.swift
//  VIPExampleTests
//
//  Created by Lefteris Kostakis on 29/3/23.
//

import XCTest
@testable import VIPExample

final class CarModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCardModelIsConstructedCorrectlyFromCarDTO() throws {
        // Given
        let carDTO = CarDTO.init(model: "Lada Niva",
                                 imageURL: "http://someimage.png",
                                 manufacturedDate: "2022-10-3",
                                 engineType: "petrol")

        // When
        let car = try CarModel(carDTO: carDTO)

        // Then
        XCTAssertEqual(car.model, "Lada Niva", "The model should be the same as the carDTO")
        XCTAssertEqual(car.imageURL, URL(string: "http://someimage.png")!)
//        XCTAssertEqual(car.manufacturedDate, Date)
        XCTAssertEqual(car.engineType, .petrol)
    }

    func testCarModelIsNotCreatedIfImageURLIsInvalid() {
        // Given
        let carDTO = CarDTO.init(model: "Lada Niva",
                                 imageURL: "\\httw//someimage.png",
                                 manufacturedDate: "2022-10-3",
                                 engineType: "Petrol")

        // When
        // Then
        XCTAssertThrowsError(try CarModel(carDTO: carDTO))
    }

    func testCarModelIsNotCreatedIfDateIsInvalid() {
        // Given
        let carDTO = CarDTO.init(model: "Lada Niva",
                                 imageURL: "http://someimage.png",
                                 manufacturedDate: "3-10-2022",
                                 engineType: "Petrol")

        // When
        var carError: CarModel.CarError!
        do {
            try CarModel(carDTO: carDTO)
        } catch let error {
            carError = error as? CarModel.CarError
        }
        // Then
        XCTAssertEqual(carError, .invalidDateFormat, "Should throw invalid date error")
    }

}
