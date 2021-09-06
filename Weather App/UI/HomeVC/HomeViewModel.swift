//
//  HomeViewModel.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import Foundation


class HomeViewModel {
    
    var settingsPressed: EmptyCallback?
    var searchPressed: EmptyCallback?
    var onActivityStarted: EmptyCallback?
    var onActivityEnded: EmptyCallback?
    var onFetchSucces: ((Weather, Settings)->Void)?
    var onFetchFail: ((String)->Void)?
    
    private let networkWeatherService: NetworkWeatherServiceProtocol
    private let locationService: LocationServiceProtocol
    
    init(locationService: LocationServiceProtocol, networkService: NetworkWeatherServiceProtocol) {
        self.networkWeatherService = networkService
        self.locationService = locationService
    }
    
    func fetchWeather(){
        
        let settings = readSettingsFromDefaults() ?? Settings.defaultSettings()
       
        var savedWeather = readWeatherFromDefaults()
        if savedWeather != nil {
            if settings.isCelsius == true {
                changeToCelsius(weather: &savedWeather!)
            }
            self.onFetchSucces?(savedWeather!, settings)
            return
        }
        print("No saved weather found. Getting form location....")
        locationService.requestPermission()
        let location = locationService.fetchCurrentLocation()
        onActivityStarted?()
        networkWeatherService.fetchWeatherLocation(lat: location.coordinate.latitude, long: location.coordinate.longitude) {
            [weak self]
            result in
            self?.onActivityEnded?()
            switch result {
            case .success(var weather):
                if settings.isCelsius == true {
                    self?.changeToCelsius(weather: &weather)
                }
                self?.onFetchSucces?(weather, settings)
            case .failure(let error):
                print(error)
                self?.onFetchFail?(error.rawValue)
            }
        }
        
    }
    fileprivate func fahrenheitToCelsius(fahrenheit: Double) -> Double{
        
        let celsius = (fahrenheit - 273.15)
        return round(celsius * 100)/100
        
    }
    fileprivate func changeToCelsius( weather: inout Weather){
        
        weather.temperature = fahrenheitToCelsius(fahrenheit: weather.temperature)
        weather.minTemperature = fahrenheitToCelsius(fahrenheit: weather.minTemperature)
        weather.maxTemperature = fahrenheitToCelsius(fahrenheit: weather.maxTemperature)
        
    }
    
}

extension HomeViewModel {
    // MARK: - Navigation
    public func onSearchPressed(){
        searchPressed?()
    }
    
    public func onSettingsPressed(){
        settingsPressed?()
    }
    
}

//MARK: - Cashing
extension HomeViewModel {
    
    func deleteWeatherFromDefaults(){
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "weather")
        
    }
    fileprivate func readWeatherFromDefaults() -> Weather?{
        
        let defaults = UserDefaults.standard
        guard
        let encodedData = defaults.value(forKey: "weather") as? Data
        else {
            print("Converting to data filed :(")
            return nil
        }
        return Weather.fromData(data: encodedData)
        
    }
    fileprivate func readSettingsFromDefaults() -> Settings?{
        
        let defaults = UserDefaults.standard
        guard
        let encodedData = defaults.value(forKey: "settings") as? Data
        else {
            print("Converting to data filed :(")
            return nil
        }
        return Settings.fromData(data: encodedData)
        
    }
    
}
