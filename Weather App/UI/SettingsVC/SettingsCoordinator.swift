//
//  SearchCoordinator.swift
//  Weather App
//
//  Created by Ivan Stajcer on 01.09.2021..
//

import Foundation
import UIKit
import SnapKit

class SettingsCoordinator : Coordinator {
    var onScreenExit: ((Settings)->Void)?
    
    func start() -> UIViewController {
        let vc = createSettingsVC()
        return vc
    }
 
    private func createSettingsVC() -> UIViewController {
        let vc = SettingsViewController()
        let vm = SettingsViewModel()
        vm.onScreeExit = { [weak self] settings in
            self?.onScreenExit?(settings)
        }
        vc.settingsViewModel = vm
        return vc
    }
    
}

