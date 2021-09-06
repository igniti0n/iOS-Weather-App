//
//  SettingsViewController.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import UIKit

class SettingsViewController: UIViewController {
    var settingsView = SettingsView()
    var settingsViewModel : SettingsViewModel?
    
    override func loadView() {
        super.loadView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCallbacks()
        settingsViewModel?.readSettingsFromDefaults()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        settingsViewModel?.saveSettingsToDefaults()
    }
    
    fileprivate func addCallbacks(){
        settingsView.settingsChanged = { [weak self] settings in
            self?.settingsViewModel?.settingsChanged(newSettings: settings)
        }
        settingsViewModel?.onSettingsLoaded = { [weak self] settings in
            DispatchQueue.main.async {
                self?.settingsView.updateView(settings: settings)
            }
        }
    }
    
}
