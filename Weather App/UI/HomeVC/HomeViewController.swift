//
//  HomeViewController.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    var homeViewModel : HomeViewModel!
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
        homeViewModel.deleteWeatherFromDefaults()
        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.fetchWeather()
    }
    
    fileprivate func addCallbacks(){
        
        homeView.searchButtonPressed = {
            [weak self] in
            self?.homeViewModel.onSearchPressed()
        }
        homeView.settingsButtonPressed = {
            [weak self] in
            self?.homeViewModel.onSettingsPressed()
        }
        homeViewModel.onFetchSucces = {
            [weak self] weather,settings in
            DispatchQueue.main.async {
                self?.homeView.updateWeatherView(weather: weather, settings: settings)
            }
        }
        homeViewModel.onFetchFail = {
            [weak self] error in
            DispatchQueue.main.async {
                self?.showMessage(title: "Fetching failed.", messagae: error)
            }
           
        }
        homeViewModel.onActivityStarted = {
            [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
            }
          
        }
        homeViewModel.onActivityEnded = {
            [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
            
        }
       
    }

}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            homeViewModel.fetchWeather()
        }
        
    }
    
}
