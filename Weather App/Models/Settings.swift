//
//  Settings.swift
//  Weather App
//
//  Created by Ivan Stajcer on 02.09.2021..
//

import Foundation

struct Settings : Codable {
    
    let isCelsius : Bool
    let isFarenheit : Bool
    let showHumidity : Bool
    let showPressure : Bool
    let showWind : Bool
    
    static func defaultSettings()->Settings{
        Settings(
            isCelsius: true,
            isFarenheit: false,
            showHumidity: true,
            showPressure: true,
            showWind: true
        )
    }
    
    static func fromData(data: Data) -> Settings?{
        let encoder = JSONDecoder()
        return try? encoder.decode(Settings.self, from: data)
    }
    
    func toData() -> Data?{
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
}
