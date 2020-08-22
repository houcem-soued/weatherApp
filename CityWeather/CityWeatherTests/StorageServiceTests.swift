//
//  StorageServiceTests.swift
//  CityWeatherTests
//
//  Created by Houcem Soued on 16/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import XCTest
@testable import CityWeather

extension StorageService {
    static let mock = StorageService(withPath: "citiesMock")
}

class StorageServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()

        Current = .mock
    }
    
    func testSaveCities() {
        let cities = getCitiesMock()
        Current.storageService.saveCities(cities)
        
        var storedCities = Current.storageService.loadCities()
        XCTAssert(cities == storedCities)
        
        Current.storageService.saveCities([])

        storedCities = Current.storageService.loadCities()
        XCTAssert(storedCities == [])
    }

}

extension StorageServiceTests {
    func getCitiesMock() -> [City] {
        
        let city1 = City(name: "Toulon", temperature: 29, weatherDescription: "Clear", weatherTitle: "Clear", iconName: "01d", maxTemperature: 32, minTemperature: 24, humidity: 80, pressure: 1029)
        
        let city2 = City(name: "Paris", temperature: 22, weatherDescription: "Cloudy", weatherTitle: "Cloudy", iconName: "01d", maxTemperature: 23, minTemperature: 20, humidity: 80, pressure: 1029)
        
        let city3 = City(name: "Madrid", temperature: 36, weatherDescription: "Clear", weatherTitle: "Clear", iconName: "01d", maxTemperature: 39, minTemperature: 29, humidity: 80, pressure: 1029)
        
        return [city1, city2, city3]
    }
}
