//
//  CitiesListCoordinator.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation
import UIKit

class CitiesListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private var navigationController : UINavigationController
    
    var onAddCityEvent: (City)->() = { _ in }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CitiesListViewController") as? CitiesListViewController else {
                return
        }
        let viewModel = CitiesListViewModel()
        viewController.viewModel = viewModel
        viewController.viewModel?.coordinator = self
        
        onAddCityEvent = viewModel.addNewCity
        
        self.navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showAddCityScreen() {
        let addCityCoordinator = AddCityCoordinator(navigationController: navigationController)
        addCityCoordinator.parentCoordinator = self
        addCityCoordinator.start()
        childCoordinators.append(addCityCoordinator)
    }
    
    func showCityDetailsScreen(city: City) {
        let cityDetailsCoordinator = CityDetailsCoordinator(navigationController: navigationController, city: city)
        cityDetailsCoordinator.parentCoordinator = self
        cityDetailsCoordinator.start()
        childCoordinators.append(cityDetailsCoordinator)
    }
}
