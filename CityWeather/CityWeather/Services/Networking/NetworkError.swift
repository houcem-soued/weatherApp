//
//  NetworkError.swift
//  CityWeather
//
//  Created by Houcem Soued on 14/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case invalidParameters
    case invalidResponse
    case noInternetConnection
    case noResultFound
    
    case invalidApiKey
    
    var localizedDescription: String {
        
        switch self {
        case .unknown:
            return "unknown_error"
        case .invalidParameters:
            return "invalid_parameters_error"
        case .invalidResponse:
            return "invalid_response_error"
        case .noResultFound:
            return "no_result_found_error"
        case .noInternetConnection:
            return "no_Internet_Connection_error"
        case .invalidApiKey:
            return "invalid_api_key"
        }
    }
    
    var previewImageName: String {
        switch self {
        case .noResultFound:
            return "no-data"
        case .noInternetConnection:
            return "network-error"
        default:
            return "network-error"
        }
    }
    
    static func getNetworkError(from error: NSError?) -> NetworkError {
        guard let error = error else {
            return .unknown
        }
        
        switch error.code {
        case 401:
            return .invalidApiKey
        case 404:
            return .noResultFound
        case 530:
            return .invalidParameters
        case 540:
            return .invalidResponse
        default:
            return .unknown
        }
    }
}
