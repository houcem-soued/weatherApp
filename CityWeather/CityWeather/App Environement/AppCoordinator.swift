//
//  AppCoordinator.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator : class {
    var childCoordinators : [Coordinator] { get set }
    func start()
    func childDidFinish(childCoordinator: Coordinator)
}

class AppCoordinator : Coordinator {
    var childCoordinators : [Coordinator] = []
    private var navigationController : UINavigationController!
    private let window : UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        navigationController = UINavigationController()
        
        let citiesCoordinator = CitiesListCoordinator(navigationController: navigationController)
        citiesCoordinator.start()
        
        //Customize navigation bar
        self.navigationController.navigationBar.isHidden = false
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.shadowImage = UIImage()
        self.navigationController.navigationBar.isTranslucent = true
        self.navigationController.navigationBar.tintColor = UIColor(named: "brown")
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension Coordinator {
    func childDidFinish(childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: {
            (coordinator: Coordinator) -> Bool in
            childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
