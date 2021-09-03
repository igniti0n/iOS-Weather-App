//
//  Settings.swift
//  Weather App
//
//  Created by Ivan Stajcer on 02.09.2021..
//

import Foundation

struct Settings : Codable {
    
    var isCelsius : Bool
    var isFarenheit : Bool
    var showHumidity : Bool
    var showPressure : Bool
    var showWind : Bool
    
}
