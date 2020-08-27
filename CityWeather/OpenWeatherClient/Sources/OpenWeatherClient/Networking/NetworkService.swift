//
//  NetworkService.swift
//  CitiesWeather
//
//  Created by Houcem on 03/08/2020.
//  Copyright © 2020 Houcem. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Result type
typealias NetworkResult = Result<Data, NSError>

// MARK: - Protocol
protocol NetworkService {
    func performRequest(url: URL, completion: @escaping (NetworkResult) -> Void)
}

// MARK: - Implementation
final class NetworkDataFetcher: NetworkService {
    private let session: NetworkSession
        
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func performRequest(url: URL, completion: @escaping (NetworkResult) -> Void) {       
        session.loadData(from: url) { (data, response, error) in
            let result: NetworkResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            guard error == nil,
                let response = response as? HTTPURLResponse, (200 ... 299).contains(response.statusCode),
                let data = data else {
                    result = .failure(NSError(domain: "OpenWeatherClient", code: 540))//invalidResponse
                    return
            }
            result = .success(data)
        }
    }
}

protocol NetworkSession {
    func loadData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    
    static var cityWeatherSession: URLSession {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 50.0
        return URLSession(configuration: sessionConfig)
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}
