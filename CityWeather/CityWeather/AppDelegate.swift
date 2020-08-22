//
//  AppDelegate.swift
//  CityWeather
//
//  Created by Houcem Soued on 12/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        guard !areTestsRunning() else {
            return true
        }
        
        let appCoordinator = AppCoordinator(window: window ?? UIWindow())
        appCoordinator.start()
        
        return true
    }
    
    //check if the app is running test
    //we need to quick exit SceneDelegate if we are running tests to avoid any unwanted behavors
    private func areTestsRunning() -> Bool {
      return NSClassFromString("XCTest") != nil
    }
}

