//
//  AddCityCoordinator.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation
import UIKit

class AddCityCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private var navigationController : UINavigationController
    
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "AddCityViewController") as? AddCityViewController else {
                return
        }
        viewController.viewModel = AddCityViewModel()
        viewController.viewModel?.coordinator = self
        
        self.navigationController.present(viewController, animated: true, completion: nil)
    }
    
    func didFinishAddCity(city: City? = nil) {
        guard let coordinator = parentCoordinator as? CitiesListCoordinator else {
            return
        }
        
        if let city = city {
            coordinator.onAddCityEvent(city)
        }
        coordinator.childDidFinish(childCoordinator: self)
        navigationController.dismiss(animated: true, completion: nil)
    }
}
