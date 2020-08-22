//
//  OpenWeatherApi.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation
import OpenWeatherClient

struct OpenWeatherApi {
    //Setup with your DEV Environement url
    static let dev = OpenWeatherApi(apiKey: "f6537f36daf15a03fe42f3d607573053")
    //Setup with your PROD Environement url
    static let prod = OpenWeatherApi(apiKey: "f6537f36daf15a03fe42f3d607573053")

    let apiKey: String
    var fetchCityWeather: (String?,@escaping (Result<City, NetworkError>) -> Void) -> Void
    var fetchCitiesWeather: ([String],@escaping (Result<[City], NetworkError>) -> Void) -> Void

    init(apiKey: String) {
        self.apiKey = apiKey
        fetchCityWeather = fetchWeather(city: completion:)
        fetchCitiesWeather = fetchWeather(cities: completion:)
        
        OpenWeatherClient.start(apiKey: apiKey)
    }
}

func fetchWeather(city: String?, completion: @escaping (Result<City, NetworkError>) -> Void) {
    guard Current.networkStatus.isConnectedToNetwork() else {
        completion(.failure(.noInternetConnection))
        return
    }
    
    OpenWeatherClient.getCityWeather(cityName: city) { (result) in
        switch result {
        case .success(let cityWeather):
            let city = City(weather: cityWeather)
            completion(.success(city))
        case .failure(let error):
            completion(.failure(NetworkError.getNetworkError(from: error)))
        }
    }
}

func fetchWeather(cities: [String], completion: @escaping (Result<[City], NetworkError>) -> Void) {
    guard Current.networkStatus.isConnectedToNetwork() else {
        completion(.failure(.noInternetConnection))
        return
    }
    
    var citiesResult = [City]()
    let dispatchGroup = DispatchGroup()
    
    _ = cities.map { cityName in
        dispatchGroup.enter()
        fetchWeather(city: cityName) { result in
            dispatchGroup.leave()
            if case let .success(city) = result {
                citiesResult.append(city)
            }
        }
    }
    dispatchGroup.notify(queue: .main){
        completion(.success(citiesResult))
    }
}

