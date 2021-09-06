//
//  SearchViewModel.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import Foundation


class SearchViewModel {
    
    var searchedCities = [String]()
    var onActivityStarted: EmptyCallback?
    var onActivityEnded: EmptyCallback?
    var onFetchSucces: ((Bool)->Void)?
    var onFetchFail: ((String)->Void)?
    
    private let networkWeatherService: NetworkWeatherServiceProtocol
    
    init(networkWeatherService: NetworkWeatherServiceProtocol) {
        self.networkWeatherService = networkWeatherService
    }
    
    public func fetchWeatherForCity(city: String){
        
        onActivityStarted?()
        networkWeatherService.fetchWeatherCity(city: city) {
            [weak self]
            result in
            self?.onActivityEnded?()
            switch result {
            case .success(let weather):
                self?.fetchSuccess(weather: weather)
            case .failure(let error):
                print(error)
                self?.fetchFail(errorMessage: error.rawValue)
            }
        }
        
    }
    
    fileprivate func fetchSuccess(weather: Weather){
        
        let result = saveToDefaults(weather: weather)
        if  result != nil {
            fetchFail(errorMessage: result!)
        }else{
            updateSearchedCities(city: weather.name)
        }
        
    }
    
    fileprivate func updateSearchedCities(city: String){
        if searchedCities.contains(city){
            onFetchSucces?(false)
        }else{
            print("City not in array, adding it now.")
            searchedCities.insert(city, at: 0)
            onFetchSucces?(true)
        }
    }
    
    fileprivate func fetchFail(errorMessage: String){
        onFetchFail?(errorMessage)
    }
    
    
    
}

extension SearchViewModel {
    
    //MARK: - User defaults
    func saveToDefaultsCities(){
        
        let defaults = UserDefaults.standard
        guard
        let encodedData = try? JSONEncoder().encode(searchedCities)
        else {
            return
        }
        defaults.setValue(encodedData, forKey: "cities")
        
    }
    
    func readFromDefaultsCities(){
        
        let defaults = UserDefaults.standard
        guard
        let encodedData = defaults.data(forKey: "cities"),
        let savedCities = try? JSONDecoder().decode(Array<String>.self, from: encodedData)
        else {
            return
        }
        searchedCities += savedCities.sorted()
        
    }
    
    fileprivate func saveToDefaults(weather: Weather) -> String?{
        
        let defaults = UserDefaults.standard
        guard
        let encodedData = weather.toData()
        else {
            return "Failed to convert data."
        }
        defaults.setValue(encodedData, forKey: "weather")
        return nil
        
    }
}
