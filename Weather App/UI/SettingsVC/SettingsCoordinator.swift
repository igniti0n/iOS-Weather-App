//
//  SearchCoordinator.swift
//  Weather App
//
//  Created by Ivan Stajcer on 01.09.2021..
//

import Foundation
import UIKit
import SnapKit

/*
 nisam dodao još funkcinalnosti, samo da se moze prikazati
 */

class SettingsCoordinator : Coordinator {
    
    func start() -> UIViewController {
        let vc = createSettingsVC()
       
        return vc
    }
    
   
    
    private func createSettingsVC() -> UIViewController{
        let vc = SettingsViewController()
        let vm = SettingsViewModel()
        
        vc.settingsViewModel = vm
        return vc
    }
    
  
    
}

