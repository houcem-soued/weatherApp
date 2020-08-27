//
//  OpenWeatherEndPoints.swift
//  
//
//  Created by Houcem Soued on 22/08/2020.
//

import Foundation

struct OpenWeatherEndPoint {
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather"    
    var type: OpenWeatherEndPointType
}

enum OpenWeatherEndPointType {
    case fetchCityWeather(String?)
    
    var url: URL? {
        switch self {
        case .fetchCityWeather(let city):
            var queryItems = [URLQueryItem]()
                queryItems.append(URLQueryItem(name: "q", value: city))
                queryItems.append(URLQueryItem(name: "appid", value: OpenWeatherClient.apiKey))
                queryItems.append(URLQueryItem(name: "units", value: "metric"))
            
            var urlComponents = URLComponents(string: OpenWeatherEndPoint.baseURL)
            urlComponents?.queryItems = queryItems
            return  urlComponents?.url
        }
    }
    
}
