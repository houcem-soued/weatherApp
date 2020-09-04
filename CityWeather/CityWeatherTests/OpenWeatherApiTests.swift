//
//  OpenWeatherApiTests.swift
//  CityWeatherTests
//
//  Created by Houcem Soued on 16/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import XCTest
@testable import CityWeather

extension OpenWeatherApi {
    static let mockInvalidKey = OpenWeatherApi(apiKey: "XXX")
    static let mock = OpenWeatherApi(apiKey: "f6537f36daf15a03fe42f3d607573053")
}

class OpenWeatherApiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Current = Environment.mock
    }
    
    override func setUpWithError() throws {
        Current = Environment.mock
    }
    
    override func tearDownWithError() throws {
        Current = Environment.mock
    }
    
    // MARK: - FetchCityWeather tests
    func testFetchCityWeatherSuccess() {
        let exp = expectation(description: "elements returned not nil")
        Current.openWeatherApi.fetchCityWeather("Paris"){ result in
            guard case .success(let city) = result else { XCTAssert(false) ; return }
            exp.fulfill()
            XCTAssert(city.name != nil)
        }
        waitForExpectations(timeout: 5.0) { (error) in
            if let error = error { XCTFail("Failed on timeout with error \(error)") }
        }
    }
    
    func testFetchCityWeather_CityNameFail() {
        let exp = expectation(description: "return error == invalidResponse")
        Current.openWeatherApi.fetchCityWeather("*** ** *"){ result in
            guard case .failure(let error) = result else { XCTAssert(false) ; return }
            exp.fulfill()
            XCTAssert(error == .invalidResponse)
        }
        waitForExpectations(timeout: 5.0) { (error) in
            if let error = error { XCTFail("Failed on timeout with error \(error)") }
        }
    }

    // MARK: - FetchCitiesWeather tests
    func testFetchCitiesWeatherSuccess() {
        let exp = expectation(description: "elements returned > 0")
        Current.openWeatherApi.fetchCitiesWeather(["Paris","Nice"]){ result in
            guard case .success(let cities) = result else { XCTAssert(false) ; return }
            exp.fulfill()
            XCTAssert(cities.count > 0 )
        }
        waitForExpectations(timeout: 5.0) { (error) in
            if let error = error { XCTFail("Failed on timeout with error \(error)") }
        }
    }
    
    func testFetchCityWeather_NoInputSuccess() {
        let exp = expectation(description: "elements returned == 0")
        Current.openWeatherApi.fetchCitiesWeather([]){ result in
            guard case .success(let cities) = result else { XCTAssert(false) ; return }
            exp.fulfill()
            XCTAssert(cities.count == 0 )
        }
        waitForExpectations(timeout: 5.0) { (error) in
            if let error = error { XCTFail("Failed on timeout with error \(error)") }
        }
    }
}
