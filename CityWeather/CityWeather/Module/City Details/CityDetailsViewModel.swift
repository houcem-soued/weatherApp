//
//  CityDetailsViewModel.swift
//  CityWeather
//
//  Created by Houcem Soued on 13/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation
class CityDetailsViewModel {
    
    var coordinator: CityDetailsCoordinator?
    let city: City
    
    init(city: City) {
        self.city = city
    }
    
    func viewWillDisappear() {
        coordinator?.cityDetailsDidFinish()
    }
}
