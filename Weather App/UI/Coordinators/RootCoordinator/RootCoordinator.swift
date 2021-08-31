//
//  RootCoordinator.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import Foundation
import UIKit
import SnapKit

class RootCoordinator : Coordinator {
    
    var navigationController = UINavigationController()
    
    var weather : Weather?
    
    func start() -> UIViewController {
        let vc = createHomeVC()
        navigationController.showAsRoot()
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }
    
    private func createHomeVC() -> UIViewController{
        let vc = HomeViewController()
        let vm = HomeViewModel()
        //add callbacks...
        
        vc.homeViewModel = vm
        return vc
    }
    
    private func createSettingsVC() -> UIViewController{
        let vc = SettingsViewController()
        
        
        return vc
    }
    
    private func createSearchVC() -> UIViewController{
        let vc = SearchViewController()
        
        return vc
    }
    
    
}
