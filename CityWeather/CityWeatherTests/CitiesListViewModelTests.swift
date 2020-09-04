//
//  CitiesListTests.swift
//  CityWeatherTests
//
//  Created by Houcem Soued on 16/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import XCTest
@testable import CityWeather

class CitiesListViewModelTests: XCTestCase {

    var citiesListViewModel = CitiesListViewModel(openWeatherApi: Current.openWeatherApi,
                                                  storageService: Current.storageService)
    
    override func setUp() {
        super.setUp()
        
        citiesListViewModel.cities = getCitiesMock()
    }
    
    func testGetCity(){
        citiesListViewModel.cities = getCitiesMock()
        let city1 = citiesListViewModel.getCity(at: 0)
        let city2 = citiesListViewModel.getCity(at: 10)
        let city3 = citiesListViewModel.getCity(at: -5)

        XCTAssert(city1 != nil )
        XCTAssert(city1?.name?.uppercased() == "toulon".uppercased())
        
        XCTAssert(city2 == nil )
        XCTAssert(city3 == nil )
    }
    
    func testAddNewCity(){
        citiesListViewModel.cities = getCitiesMock()
        XCTAssert(citiesListViewModel.cities.count == 3)
        
        citiesListViewModel.addNewCity(city: City(name: "Monastir",
                                                  temperature: 35,
                                                  weatherDescription: "Clear",
                                                  weatherTitle: "Clear",
                                                  iconName: "01d",
                                                  maxTemperature: 38,
                                                  minTemperature: 29,
                                                  humidity: 40,
                                                  pressure: 1002  ))
        XCTAssert(citiesListViewModel.cities.count == 4)
    }
    
    func testRefreshData(){
        citiesListViewModel.refeshData(with: getCitiesMock(), error: nil)
        XCTAssert(citiesListViewModel.cells.count == getCitiesMock().count)
    }
    
    func testRefreshDataWithError(){
        citiesListViewModel.refeshData(with: [], error: .noInternetConnection)
        XCTAssert(citiesListViewModel.cells.count == 1)
    }
    
    func testGetNumberOfCells(){
        citiesListViewModel.refeshData(with: getCitiesMock(), error: nil)
        XCTAssert(citiesListViewModel.getNumberOfCells() == getCitiesMock().count)
    }
    
    func testGetNumberOfCellsWhileError(){
        citiesListViewModel.refeshData(with: [], error: .noResultFound)
        XCTAssert(citiesListViewModel.getNumberOfCells() == 1)
    }
    

}

extension CitiesListViewModelTests {
    func getCitiesMock() -> [City] {
        
        let city1 = City(name: "Toulon", temperature: 29, weatherDescription: "Clear", weatherTitle: "Clear", iconName: "01d", maxTemperature: 32, minTemperature: 24, humidity: 80, pressure: 1029)
        
        let city2 = City(name: "Paris", temperature: 22, weatherDescription: "Cloudy", weatherTitle: "Cloudy", iconName: "01d", maxTemperature: 23, minTemperature: 20, humidity: 80, pressure: 1029)
        
        let city3 = City(name: "Madrid", temperature: 36, weatherDescription: "Clear", weatherTitle: "Clear", iconName: "01d", maxTemperature: 39, minTemperature: 29, humidity: 80, pressure: 1029)
        
        return [city1, city2, city3]
    }
}
