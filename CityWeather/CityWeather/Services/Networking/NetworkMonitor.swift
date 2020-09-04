//
//  NetworkMonitor.swift
//  CityWeather
//
//  Created by MacBook Pro on 01/09/2020.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import Foundation
import Network

class NetworkStatus {
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    private(set) var isConnected: Bool = true

    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
    
    convenience init(connectionStatus: Bool) {
        self.init()
        self.isConnected = connectionStatus
    }

    func start() {
        self.monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
    }

    func stop() {
        self.monitor.cancel()
    }
}

extension NetworkStatus {
    static let live = NetworkStatus()
    static let satisfied = NetworkStatus(connectionStatus: true)
    static let unsatisfied = NetworkStatus(connectionStatus: false)
}
