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
    
    func getWeather(by cityName: String?) {
        showLoader(true)
        Current.openWeatherApi.fetchCityWeather(cityName) { result in
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
