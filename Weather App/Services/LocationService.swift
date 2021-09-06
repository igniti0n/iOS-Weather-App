//
//  LocationService.swift
//  Weather App
//
//  Created by Ivan Stajcer on 03.09.2021..
//

import Foundation
import UIKit
import CoreLocation

public protocol LocationServiceProtocol {
    
    func setDelegate(vc: CLLocationManagerDelegate)
    func fetchCurrentLocation() -> CLLocation
    func requestPermission()
    
}

final class LocationService: LocationServiceProtocol {
    
    private lazy var locatioManager = CLLocationManager()
    
    func setDelegate(vc: CLLocationManagerDelegate){
        locatioManager.delegate = vc
    }
    
    func requestPermission() {
        locatioManager.requestWhenInUseAuthorization()
    }
    
    func fetchCurrentLocation() -> CLLocation {
        print("Current location: \(locatioManager.location)")
        return locatioManager.location ?? CLLocation(latitude: 45.5550, longitude: 18.6955)
    }

}
