//
//  ServicesFactory.swift
//  Weather App
//
//  Created by Ivan Stajcer on 03.09.2021..
//

import Foundation

final class ServiceFactory {
    
    static let connectivityCheckerService: ConnectionCheckerServiceProtocol = {
       ConnectionCheckerService()
    }()
    
    static let networkWeatherService: NetworkWeatherServiceProtocol = {
       NetworkWeatherService(connectivityCheckerService: connectivityCheckerService)
    }()
    
    static let locationService: LocationServiceProtocol = {
       LocationService()
    }()
    
}
