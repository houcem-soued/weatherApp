//
//  EnvironementMock.swift
//  CityWeatherTests
//
//  Created by Houcem Soued on 16/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation

extension Environment {
    static let mock = Environment(openWeatherApi: .mock,
                                  storageService: .mock,
                                  networkStatus: NetworkStatus())
}
