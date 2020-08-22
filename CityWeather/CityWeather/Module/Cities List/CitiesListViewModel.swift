//
//  CitiesListViewModel.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation

class CitiesListViewModel {
    
    var coordinator: CitiesListCoordinator?
    var cities = [City]()
    var refreshView = {}
    var showLoader: (Bool)-> Void = { _ in }

    internal var cells = [CitiesListViewModel.Cell]()

    private var isConnectedToNetwork: Bool {
        Current.networkStatus.isConnectedToNetwork()
    }
    
    // MARK: - public functions
    func getCitiesWeather() {
        self.cities = self.retrieveStoredCities()
        let citiesNames = cities.compactMap { $0.name }
        
        //if connected to network: refresh data from api
        //if not connected to network: refresh data using storage data
        isConnectedToNetwork ? getCitiesWeatherFromNetwork(with: citiesNames) : refeshData(with: cities)
    }
    
    func showAddCity() {
        coordinator?.showAddCityScreen()
    }
    
    func showCityDetails(city: City) {
        coordinator?.showCityDetailsScreen(city: city)
    }
    
    func getCity(at index: Int) -> City? {
        guard index >= 0 && index < cities.count else {
            return nil
        }
        return cities[index]
    }
    
    func addNewCity(city: City) {
        //if city already exists replace it with the new value
        if let cityIndex = cities.firstIndex(of: city) {
            cities[cityIndex] = city
        }else {
            cities.insert(city, at: 0)
        }
        saveCities(cities: cities)
        refeshData(with: cities)
    }

    internal func refeshData(with citiesResult: [City] = [], error: NetworkError? = nil) {
        cities = citiesResult
        setupCells(with: cities, error: error)
        refreshView()
    }
}

// MARK: - TableView functions
extension CitiesListViewModel {
    enum Cell {
        case cityCell(city: City?)
        case errorCell(error: NetworkError?)
    }
    
    func getNumberOfCells()->Int {
        cells.count
    }
    
    func cellFor(indexPath: IndexPath) -> CitiesListViewModel.Cell?{
        guard indexPath.row >= 0, cells.count > indexPath.row else {
            return nil
        }
        return cells[indexPath.row]
    }
    
    private func setupCells(with cities: [City] = [], error: NetworkError? = nil) {
        guard error == nil else {
            //if we have an error: Display ErrorCel with that error
            cells = [.errorCell(error: error)]; return
        }
        
        guard cities.count > 0 else { //check for no data error
            let error: NetworkError = isConnectedToNetwork ? .noResultFound : .noInternetConnection
            cells = [.errorCell(error: error)]; return
        }
        //Create as much city cells as our cities data
        cells = cities.map {
            Cell.cityCell(city: $0)
        }
    }
}

// MARK: - Storage functions
extension CitiesListViewModel {
    private func saveCities(cities: [City]) {
        Current.storageService.saveCities(cities)
    }
    
    private func retrieveStoredCities()-> [City] {
        return Current.storageService.loadCities()
    }
}

// MARK: - Network functions
extension CitiesListViewModel {
    func getCitiesWeatherFromNetwork(with citiesNames: [String]) {
        showLoader(true)
        Current.openWeatherApi.fetchCitiesWeather(citiesNames) {[weak self] result in
            self?.showLoader(false)
            switch result {
            case .success(let cities):
                self?.refeshData(with: cities)
            case .failure(let error):
                self?.refeshData(error: error)
            }
        }
    }
}
