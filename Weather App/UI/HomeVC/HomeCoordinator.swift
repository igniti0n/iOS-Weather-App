//
//  HomeCoordinator.swift
//  Weather App
//
//  Created by Ivan Stajcer on 02.09.2021..
//

import  UIKit

class HomeCoordinator : Coordinator {
    
/*
     HOME COORDINATOR IMA NAVIGATION CONTROLLER, KOJI STAVLJA SETTINGS
    ILI SEARCH NA NJEGA
 */
    let navigationController = UINavigationController()
    
    func start() -> UIViewController {
        let vc = createHomeVC()
       
        navigationController.showAsRoot()
        navigationController.navigationBar.setTransparent()
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.tintColor = UIColor.black
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
    
   
    
    private func createHomeVC() -> UIViewController{
        let vc = HomeViewController()
        let vm = HomeViewModel()
        
        vm.settingsPressed = {
            [weak self] in
            self?.showSettingsVC()
        }
        
        vm.searchPressed = {
            [weak self] in
            self?.showSearchVC()
        }
        
        
        
        vc.homeViewModel = vm
        return vc
    }
    
    private func showSettingsVC(){
        
        let coordinator = SettingsCoordinator()
        let vc = coordinator.start()
        navigationController.pushViewController(vc, animated: true)
       
    }
    
    private func showSearchVC(){
        
        let coordinator = SearchCoordinator()
        let vc = coordinator.start()
        navigationController.pushViewController(vc, animated: true)
        
    }
    
  
    
}
