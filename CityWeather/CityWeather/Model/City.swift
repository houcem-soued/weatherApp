//
//  City.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation
import OpenWeatherClient

struct City: Codable {
    var name: String?
    var temperature: Int?
    var weatherDescription: String?
    var weatherTitle: String?
    var iconName: String?
    var maxTemperature: Double?
    var minTemperature: Double?
    var humidity: Int?
    var pressure: Int?

    init(weather: CityWeather?) {
        self.name = weather?.name
        self.temperature = Int(weather?.main.temp ?? 0)
        self.weatherDescription = weather?.weather.first?.weatherDescription
        self.weatherTitle = weather?.weather.first?.main
        self.humidity = weather?.main.humidity
        self.pressure = weather?.main.pressure
        self.maxTemperature = weather?.main.tempMax
        self.minTemperature = weather?.main.tempMin
        self.iconName = weather?.weather.first?.icon
    }
    
    init(name: String?, temperature: Int?, weatherDescription: String?, weatherTitle: String?, iconName: String?, maxTemperature: Double?, minTemperature: Double?, humidity: Int?, pressure: Int?) {
        self.name = name
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.weatherTitle = weatherTitle
        self.iconName = iconName
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
        self.humidity = humidity
        self.pressure = pressure
    }
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name
    }
}
