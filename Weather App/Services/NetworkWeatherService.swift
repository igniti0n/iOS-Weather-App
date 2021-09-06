//
//  NetworkWeatherService.swift
//  Weather App
//
//  Created by Ivan Stajcer on 03.09.2021..
//

import Foundation

public enum NetworkError: String, Error {
    case noInternet = "There is no connection."
    case emptyResponse = "No data recieved from the response."
    case networkError = "There seems to be a problem with fetching data."
    
    var textDescription : String {
        return self.rawValue
    }
}


protocol NetworkWeatherServiceProtocol {
    func fetchWeatherCity(city: String, completion: @escaping (Result<Weather, NetworkError>) -> Void)
    func fetchWeatherLocation(lat: Double, long: Double, completion: @escaping (Result<Weather, NetworkError>) -> Void)
}

/*
 HomeVC gets saved weather from User defaults, if there is not any
 then it is fetched from current location.
 
 SearchVC uses fetching weather data by city name, it then saves it to
 User defaults if it is successfull.
*/

final class NetworkWeatherService: NetworkWeatherServiceProtocol {
    private let connectivityCheckerService: ConnectionCheckerServiceProtocol
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "33a595b1052037a58ebbd6503b0303ac"

    init(connectivityCheckerService : ConnectionCheckerServiceProtocol){
        self.connectivityCheckerService = connectivityCheckerService
    }
    
    func fetchWeatherCity(city: String, completion: @escaping (Result<Weather, NetworkError>) -> Void){
        var components = URLComponents(string: baseUrl)!
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        fetchWeatherFromNetwork(components: components, completion: completion)
    }
    
    func fetchWeatherLocation(lat: Double, long: Double, completion: @escaping (Result<Weather, NetworkError>) -> Void){
        var components = URLComponents(string: baseUrl)!
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(long)),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        if let savedWeather = fetchWeatherFromDefaults() {
            completion(.success(savedWeather))
            return
        }
        fetchWeatherFromNetwork(components: components, completion: completion)
        
    }
    
}

fileprivate extension NetworkWeatherService {
    //MARK:- Fetching weather
    func fetchWeatherFromNetwork(components: URLComponents, completion: @escaping (Result<Weather, NetworkError>) -> Void) {
        guard
        connectivityCheckerService.isConnected == true
        else {
            completion(.failure(.noInternet))
            return
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,                              // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                error == nil                                  // was there no error
            else {
                completion(.failure(.networkError))
                return
            }
            
            guard
            let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any],
                let weather = Weather.fromJson(map: responseObject)
            else {
                completion(.failure(.emptyResponse))
                return
            }
           completion(.success(weather))
            
        }
        task.resume()
    }
    func fetchWeatherFromDefaults()-> Weather?{
        let defaults = UserDefaults.standard
        if let savedWeather = defaults.object(forKey: "weather") as? Data {
            if let decodedWeather = try? JSONDecoder().decode(Weather.self, from: savedWeather) {
                return decodedWeather
            }
        }
        return nil
    }
    
}
