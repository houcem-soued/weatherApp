//
//  String+Lacalizable.swift
//  CityWeather
//
//  Created by Houcem Soued on 15/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
