//
//  CarListInteractorTests.swift
//  VIPExampleTests
//
//  Created by Lefteris Kostakis on 29/3/23.
//

import XCTest
@testable import VIPExample

class CarModelRepositoryMocked: CarModelRepositoryProtocol {

    func fetchCars(completion: @escaping ([CarModel]) -> Void) {
        completion([])
    }
}

class CarListPresenterSpy: CarListPresenter {
    var didCallDisplayErrorEmptyResponse = false

    override func displayErrorEmptyResponse() {
        didCallDisplayErrorEmptyResponse = true
    }
}

final class CarListInteractorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testInteractorCallsDisplayErrorWhenCarArrayIsEmpty() throws {
//        // Given
//        let presenter = CarListPresenterSpy(controller: CarListTableViewController())
//        let repository = CarModelRepositoryMocked()
//        let interactor = CarListInteractor(presenter: presenter, carRepository: repository)
//
//        // When
//        interactor.viewDidLoad()
//
//        // Then
//        XCTAssertTrue(presenter.didCallDisplayErrorEmptyResponse,
//            "In empty car response the displayErrorEmptyResponse() method should be called")
//    }
}
