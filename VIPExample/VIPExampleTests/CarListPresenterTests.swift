//
//  CarListPresenterTests.swift
//  VIPExampleTests
//
//  Created by Lefteris Kostakis on 29/3/23.
//

import XCTest
@testable import VIPExample

class CarListTableViewControllerMocked: CarListViewControllerProtocol {
    var carList: [CarListPresenter.CarListViewModel]?
    func setLoadingIndicator(_ shouldDisplay: Bool) {
    }
}

final class CarListPresenterTests: XCTestCase {

    func testPresentCreatesCorrectUserDataGivenACarModel() throws {
        // Given
        let viewController = CarListTableViewControllerMocked()
        let presenter = CarListPresenter(controller: viewController)
        let carDTO = CarDTO.init(model: "Lada Niva",
                                 imageURL: "http://someimage.png",
                                 manufacturedDate: "2022-10-3",
                                 engineType: "petrol")
        let car = try CarModel(carDTO: carDTO)

        // When
        presenter.displayCars([car])

        // Then
        let carList = try XCTUnwrap(viewController.carList?.first)
        XCTAssertEqual(carList.nameAndEngine,
                       "Lada Niva - petrol",
                       "The name and engine should be the same as carDTO")
        XCTAssertEqual(carList.manufacturedDateDate,
                       "10/3/22",
                       "The date should be the same as carDTO with different format")
    }

}
