//
//  HomeViewModel.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import Foundation


class HomeViewModel {
    var currentlyDisplayingWeather: Weather?
    var settingsPressed: EmptyCallback?
    var searchPressed: EmptyCallback?
    var onSettingsScreenExited: ((Weather, Settings) -> Void)?
    var onSearchWeatherFetch: ((Weather) -> Void)?
    var onActivityStarted: EmptyCallback?
    var onActivityEnded: EmptyCallback?
    var onFetchSucces: ((Weather, Settings) -> Void)?
    var onFetchFail: ((String) -> Void)?
    
    private let networkWeatherService: NetworkWeatherServiceProtocol
    private let locationService: LocationServiceProtocol
    
    init(locationService: LocationServiceProtocol, networkService: NetworkWeatherServiceProtocol) {
        self.networkWeatherService = networkService
        self.locationService = locationService
    }
    
    func requestLoactionPermission(){
        locationService.requestPermission()
    }
    
    func deleteWeatherFromDefaults(){
        let defaults = UserDefaults.standard
        print("removing weather from defaults....")
        defaults.removeObject(forKey: "weather")
    }
    
    func fetchWeather(){
        let settings = readSettingsFromDefaults() ?? Settings.defaultSettings()
        let savedWeather = readWeatherFromDefaults()
        if var savedWeather = savedWeather {
            print("Found save weather!")
            if settings.isCelsius == true {
                changeToCelsius(weather: &savedWeather)
            }
            currentlyDisplayingWeather = savedWeather
            onFetchSucces?(savedWeather, settings)
            return
        }
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
                self?.currentlyDisplayingWeather = weather
                self?.onFetchSucces?(weather, settings)
            case .failure(let error):
                print(error)
                self?.onFetchFail?(error.rawValue)
            }
        }
    
    }
}

extension HomeViewModel {
    // MARK: - Navigation
    func onSearchPressed() {
        searchPressed?()
    }
    func onSettingsPressed() {
        settingsPressed?()
    }
    func onSettingsScreenExited(newSettings: Settings) {
        guard var currentWeather = currentlyDisplayingWeather else {return}
        let shouldChangeToCelsius = newSettings.isCelsius && currentWeather.temperature > 100
        let shouldChangeToFahrenheit = newSettings.isFarenheit && currentWeather.temperature < 100
        if shouldChangeToCelsius {
            changeToCelsius(weather: &currentWeather)
            currentlyDisplayingWeather = currentWeather
        }else if shouldChangeToFahrenheit {
            changeToFahrenheit(weather: &currentWeather)
            currentlyDisplayingWeather = currentWeather
        }
        onFetchSucces?(currentWeather, newSettings)
    }
    func onSearchWeatherFetch(weather: Weather) {
        currentlyDisplayingWeather = weather
        guard var currentWeather = currentlyDisplayingWeather else {return}
        let settings = readSettingsFromDefaults() ?? Settings.defaultSettings()
        if settings.isCelsius {
            changeToCelsius(weather: &currentWeather)
        }
        onSearchWeatherFetch?(currentWeather)
    }
}

extension HomeViewModel {
    //MARK: - Cashing
     func readWeatherFromDefaults() -> Weather? {
        let defaults = UserDefaults.standard
        guard
        let encodedData = defaults.value(forKey: "weather") as? Data
        else {
            print("Failed to read weather data from defaults.")
            return nil
        }
        return Weather.fromData(data: encodedData)
    }
    func readSettingsFromDefaults() -> Settings? {
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

fileprivate extension HomeViewModel {
    //MARK: - TEMPERATURE CONVERSION
    func changeToCelsius(weather: inout Weather){
        weather.temperature = fahrenheitToCelsius(fahrenheit: weather.temperature)
        weather.minTemperature = fahrenheitToCelsius(fahrenheit: weather.minTemperature)
        weather.maxTemperature = fahrenheitToCelsius(fahrenheit: weather.maxTemperature)
    }
    func changeToFahrenheit(weather: inout Weather){
        weather.temperature = celsiusToFahrenheit(celsius: weather.temperature)
        weather.minTemperature = celsiusToFahrenheit(celsius: weather.minTemperature)
        weather.maxTemperature = celsiusToFahrenheit(celsius: weather.maxTemperature)
    }
    func fahrenheitToCelsius(fahrenheit: Double) -> Double {
        let celsius = (fahrenheit - 273.15)
        return round(celsius * 100)/100
    }
    func celsiusToFahrenheit(celsius: Double) -> Double {
        let fahrenheit = (celsius + 273.15)
        return round(fahrenheit * 100)/100
    }
}
