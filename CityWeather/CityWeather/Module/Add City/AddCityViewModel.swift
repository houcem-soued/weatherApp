//
//  AddCityViewModel.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation

class AddCityViewModel {
    
    var coordinator: AddCityCoordinator?
    var showLoader: (Bool)-> Void = { _ in }
    var showError: (NetworkError)->Void = { _ in }
    
    private var openWeatherApi: OpenWeatherApi
    private var isConnectedToNetwork: Bool {
        Current.networkStatus.isConnected
    }
    
    init(openWeatherApi: OpenWeatherApi) {
        self.openWeatherApi = openWeatherApi
    }
    
    func getWeather(by cityName: String?) {
        guard isConnectedToNetwork else {
            showError(NetworkError.noInternetConnection)
            return
        }
        
        showLoader(true)
        openWeatherApi.fetchCityWeather(cityName) { result in
            self.showLoader(false)
            switch result {
            case .success(let city):
                self.coordinator?.didFinishAddCity(city: city)
            case .failure(let error):
                self.showError(error)
            }
        }
    }
    
    func viewWillDisappear() {
        coordinator?.didFinishAddCity()
    }
}
