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

struct Weather : Codable {
    
    var temperature : Float
    var minTemperature : Float
    var maxTemperature : Float
    var humidity : Float
    var pressure : Float
    var windSpeed : Float
    
//    enum CodingKeys: String, CodingKey {
//
//      }
    
}

