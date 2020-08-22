//
//  CityDetailsCoordinator.swift
//  CityWeather
//
//  Created by Houcem Soued on 13/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation
import UIKit

class CityDetailsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private var navigationController : UINavigationController
    private let city: City
    
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, city: City) {
        self.navigationController = navigationController
        self.city = city
    }
    
    func start() {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CityDetailsViewController") as? CityDetailsViewController else {
                return
        }
        let viewModel = CityDetailsViewModel(city: city)
        viewController.viewModel = viewModel
        viewController.viewModel?.coordinator = self
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func cityDetailsDidFinish() {
        parentCoordinator?.childDidFinish(childCoordinator: self)
    }
}
