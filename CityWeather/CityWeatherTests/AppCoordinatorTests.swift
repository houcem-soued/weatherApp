//
//  AppCoordinatorTests.swift
//  CityWeatherTests
//
//  Created by Houcem Soued on 16/08/2020.
//  Copyright © 2020 Houcem Soued. All rights reserved.
//

import XCTest
@testable import CityWeather

class AppCoordinatorTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWindowIsKey() {
        let window = WindowStub()
        let coordinator = AppCoordinator(window: window)
        coordinator.start()
        XCTAssertTrue(window.makeKeyAndVisibleCalled)
        XCTAssertNotNil(window.rootViewController)
    }
}

private class WindowStub: UIWindow {
    var makeKeyAndVisibleCalled = false
    override func makeKeyAndVisible() {
        makeKeyAndVisibleCalled = true
    }
}
