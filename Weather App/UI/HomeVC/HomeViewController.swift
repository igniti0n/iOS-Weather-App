//
//  HomeViewController.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    var homeViewModel: HomeViewModel!
    var homeView = HomeView()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        self.view.addSubview(indicator)
        indicator.center = view.center
        return indicator
    }()
    
    override func loadView() {
        super.loadView()
        addCallbacks()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.requestLoactionPermission()
        navigationItem.backButtonTitle = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        homeView.adjustFont()
    }
    
    fileprivate func addCallbacks(){
        homeView.onSearchButtonPressed = { [weak self] in
            self?.homeViewModel.onSearchPressed()
        }
        homeView.onSettingsButtonPressed = { [weak self] in
            self?.homeViewModel.onSettingsPressed()
        }
        homeViewModel.onFetchSucces = { [weak self] weather,settings in
            DispatchQueue.main.async {
                self?.homeView.updateWeatherView(weather: weather)
                self?.homeView.updateWeatherSettings(settings: settings)
            }
        }
        homeViewModel.onFetchFail = { [weak self] error in
            DispatchQueue.main.async {
                self?.showMessage(title: "Fetching failed.", messagae: error)
            }
        }
        homeViewModel.onActivityStarted = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
            }
        }
        homeViewModel.onActivityEnded = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
        homeViewModel.onSearchWeatherFetch = { [weak self] weather in
            DispatchQueue.main.async {
                self?.homeView.updateWeatherView(weather: weather)
            }
        }
       
    }

}

extension HomeViewController: CLLocationManagerDelegate {
    //MARK: - Location
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        homeViewModel.deleteWeatherFromDefaults()
        if manager.authorizationStatus == .authorizedWhenInUse {
            homeViewModel.fetchWeather()
        }
    }
    
}
