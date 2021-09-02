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
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
