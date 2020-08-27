//
//  Weather.swift
//  
//
//  Created by Houcem Soued on 22/08/2020.
//

import Foundation

// MARK: - CityWeather
public struct CityWeather: Codable {
    public let coord: Coord
    public let weather: [Weather]
    public let base: String
    public let main: Main
    public let wind: Wind
    public let dt: Int
    public let name: String
}

// MARK: - Coord
public struct Coord: Codable {
    public let lon, lat: Double
}

// MARK: - Main
public struct Main: Codable {
    public let temp, feelsLike, tempMin, tempMax: Double
    public let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Weather
public struct Weather: Codable {
    public let id: Int
    public let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
public struct Wind: Codable {
    public let speed: Double
    public let deg: Int
}
