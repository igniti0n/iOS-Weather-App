//
//  HomeCoordinator.swift
//  Weather App
//
//  Created by Ivan Stajcer on 02.09.2021..
//

import  UIKit

class HomeCoordinator : Coordinator {
    var childCoordinator: Coordinator?
    var onSearchWeatherFetch: ((Weather) -> Void)?
    var onSettingsScreenExit: ((Settings) -> Void)?
    let navigationController = UINavigationController()
    
    func start() -> UIViewController {
        let vc = createHomeVC()
        navigationController.navigationBar.setTransparent()
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.tintColor = UIColor.black
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
    
    private func createHomeVC() -> UIViewController{
        let vc = HomeViewController()
        let locationService = ServiceFactory.locationService
        locationService.setDelegate(vc: vc)
        let vm = HomeViewModel(locationService: locationService, networkService: ServiceFactory.networkWeatherService)
        vc.homeViewModel = vm
        onSearchWeatherFetch = { [weak vm] weather in
            vm?.onSearchWeatherFetch(weather: weather)
        }
        onSettingsScreenExit = { [weak vm] settings in
            vm?.onSettingsScreenExited(newSettings: settings)
        }
        vm.settingsPressed = { [weak self] in
            self?.showSettingsVC()
        }
        vm.searchPressed = { [weak self] in
            self?.showSearchVC()
        }
        return vc
    }
    
    private func showSettingsVC(){
        let settingsCoordinator = SettingsCoordinator()
        settingsCoordinator.onScreenExit = {[weak self] settings in
            self?.onSettingsScreenExit?(settings)
        }
        childCoordinator = settingsCoordinator
        let viewController = settingsCoordinator.start()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showSearchVC(){
        let searchCoordinator = SearchCoordinator()
        childCoordinator = searchCoordinator
        searchCoordinator.onSearchWeatherFetch = { [weak self] newWeather in
            self?.onSearchWeatherFetch?(newWeather)
            self?.navigationController.popViewController(animated: true)
        }
        let viewController = searchCoordinator.start()
        navigationController.pushViewController(viewController, animated: true)
    }
    
  
    
}
