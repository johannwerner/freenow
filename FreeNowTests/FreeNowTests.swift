//
//  FreeNowTests.swift
//  FreeNowTests
//
//  Created by Johann Werner on 19.09.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

import XCTest
@testable import FreeNow

class FreeNowTests: XCTestCase {
    
    // MARK: - Properties
    var useCase: LocationsListUseCase!
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
        let interactor = LocationListTestInteractor()
        let useCase = LocationsListUseCase(interactor: interactor)
        self.useCase = useCase
    }
    
    override func tearDown() {
        super.tearDown()
        useCase = nil
    }
}

extension FreeNowTests {
    func test_parsingOfCars_licensePlate() {
        //Given
        let position = Position(latitude: 0, longitude: 0)
        let nonEmptyArray = [position, position].convertToNonEmptyArray()!
        let locationModel = LocationModel(name: "", bounds: nonEmptyArray)
        let result = self.useCase.getCarListForLocation(locationModel: locationModel)
            .subscribe(onNext: { status in
                switch status {
                case .loading:
                    break
                case .error:
                    XCTAssert(false)
                case .success(let locationCarModel):
                    //When
                    let carModel = locationCarModel.poiList.first!
                    //Then
                    XCTAssertEqual(carModel.coordinate.latitude, 53)
                }
            })
        print(result)
    }
}
