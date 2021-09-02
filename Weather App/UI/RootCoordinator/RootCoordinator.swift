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
    
    /*
     PREKO OVOG POSTAVIM HOME COORDINATOR,
     on dalje zove Search i Settings kordinatore
     */
    var childCoordinator : Coordinator?
    
    func start() -> UIViewController {
        let vc = createHomeVC()
        return vc
    }
    
    private func createHomeVC() -> UIViewController{
        
        let homeCoordinator = HomeCoordinator()
        childCoordinator = homeCoordinator
        return homeCoordinator.start()
        
    }
    
}
