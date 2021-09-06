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
    
    func settingsChanged(newSettings: Settings){
        self.settings = newSettings
        print("Settings changed: \n \(settings)")

    }
    
    func saveSettingsToDefaults(){
        
        let defaults = UserDefaults.standard
        guard
        let encodedData = try? JSONEncoder().encode(settings)
        else {
            print("Converting settings to data filed :(")
            return
        }
        print("Saving settings...")
        defaults.setValue(encodedData, forKey: "settings")
        
    }
    
    func readSettingsFromDefaults(){
        
        let defaults = UserDefaults.standard
        guard
        let encodedData = defaults.value(forKey: "settings") as? Data
        else {
            print("Converting settings to data filed :(")
            return
        }
        let setFromData = Settings.fromData(data: encodedData)
        print("Read settings from data: \(setFromData)")
        settings =  setFromData ?? Settings.defaultSettings()
        onSettingsLoaded?(settings!)
        
    }
    
}
