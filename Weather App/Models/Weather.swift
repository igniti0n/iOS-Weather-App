//
//  Weather.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//
/*
 
 Ikona vremenske prognoze, Trenutna temperatura,
 Ime lokacije, Minimalna i Maximalna temperatura,
 Vlažnost zraka, Tlak zraka, te Jačina vjetra
 */

import Foundation

struct Weather : Codable, Equatable {
    
    var temperature : Double
    var minTemperature : Double
    var maxTemperature : Double
    let humidity : Double
    let pressure : Double
    let windSpeed : Double
    let conditionId : Int
    let name: String
    
    static func fromJson(map: [String:Any]) -> Weather?{
        
        guard
        let weatherDictonaryArray = map["weather"] as? [Any],
        let weatherDictonary = weatherDictonaryArray.first as? [String:Any],
        let mainDictonary = map["main"] as? [String: Any],
        let windDictonary = map["wind"] as? [String: Any],
        let name = map["name"] as? String
        else{
            return nil
        }
            
        guard
        let temp = mainDictonary["temp"] as? Double,
        let minTemp = mainDictonary["temp_min"] as? Double,
        let maxTemp = mainDictonary["temp_max"] as? Double,
        let pressure = mainDictonary["pressure"] as? Double,
        let humidity = mainDictonary["humidity"] as? Double,
        let id = weatherDictonary["id"] as? Int,
        let wind = windDictonary["speed"] as? Double
        else{
            return nil
        }

        return Weather(temperature: temp, minTemperature: minTemp, maxTemperature: maxTemp, humidity: humidity, pressure: pressure, windSpeed: wind, conditionId: id, name: name)

    }
    
    static func fromData(data: Data) -> Weather?{
        let encoder = JSONDecoder()
        return try? encoder.decode(Weather.self, from: data)
    }
    
    func toData() -> Data?{
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    
    
}

