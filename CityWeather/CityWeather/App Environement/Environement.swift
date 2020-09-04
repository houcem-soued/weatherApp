//
//  Environement.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation
//This system is introduced by Brandon Williams and Stephen Celis in www.pointfree.co series
//and was also implemented in the Kickstarter open source project (https://github.com/kickstarter/ios-oss)
//It help making depency injection easier and more accessible and testable

// wrap all project dependencies in the Environement struct
struct Environment {
    private(set) var openWeatherApi: OpenWeatherApi = .prod
    private(set) var storageService: StorageService = .prod
    
    var networkStatus: NetworkStatus = .live
}

//global varible that should be unique along the project and should be the only access to all the dependencies
var Current = Environment()
