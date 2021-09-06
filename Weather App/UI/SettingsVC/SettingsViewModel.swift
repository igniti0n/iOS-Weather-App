//
//  SettingsViewModel.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import Foundation

class SettingsViewModel {
    var settings : Settings?
    var onSettingsLoaded: ((Settings)->Void)?
    var onScreeExit: ((Settings)->Void)?
    
    func settingsChanged(newSettings: Settings) {
        self.settings = newSettings
    }
    
    func saveSettingsToDefaults() {
        let defaults = UserDefaults.standard
        guard
        let encodedData = try? JSONEncoder().encode(settings),
        let settings = settings
        else {
            return
        }
        defaults.setValue(encodedData, forKey: "settings")
        onScreeExit?(settings)
    }
    
    func readSettingsFromDefaults(){
        let defaults = UserDefaults.standard
        guard
        let encodedData = defaults.value(forKey: "settings") as? Data
        else {
            return
        }
        let setFromData = Settings.fromData(data: encodedData)
        settings =  setFromData ?? Settings.defaultSettings()
        onSettingsLoaded?(settings!)
    }
    
}
