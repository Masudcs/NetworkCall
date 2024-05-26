//
//  NetworkMonitor.swift
//  NetworkTry
//
//  Created by Md. Masud Rana on 5/26/24.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    private(set) var status: NWPath.Status = .requiresConnection {
        didSet {
            NotificationCenter.default.post(name: .networkStatusChanged, object: status)
        }
    }
    
    var isReachable: Bool { status == .satisfied }
    var isExpensive: Bool { monitor.currentPath.isExpensive }
    
    private init() {}
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self.status = path.status
            
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                print("No connection.")
            }
            print("Connection is expensive: \(path.isExpensive)")
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

// Notification Name Extension
extension Notification.Name {
    static let networkStatusChanged = Notification.Name("NetworkStatusChanged")
}
