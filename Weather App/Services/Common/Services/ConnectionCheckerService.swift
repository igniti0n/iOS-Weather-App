//
//  ConnectionCheckerService.swift
//  Weather App
//
//  Created by Ivan Stajcer on 03.09.2021..
//

import Foundation
import Alamofire

/*
 
 Using to check weather there is an active internet connection
 
 */

protocol ConnectionCheckerServiceProtocol {
    var isConnected: Bool {get}
}

final class ConnectionCheckerService: ConnectionCheckerServiceProtocol {
    let networkManager = NetworkReachabilityManager()
    
    var isConnected: Bool {
        return networkManager?.isReachable ?? false
    }
    
}


