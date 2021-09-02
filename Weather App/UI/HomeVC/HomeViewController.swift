//
//  HomeViewController.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeViewModel : HomeViewModel!
    var homeView = HomeView()
    
    var settingsPressed : (()->Void)?
    var searchPressed : (()->Void)?
    
    override func loadView() {
        super.loadView()
        addCallbacks()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        // Do any additional setup after loading the view.
    }
    
    private func addCallbacks(){
        
        homeView.searchButtonPressed = searchPressed
        homeView.settingsButtonPressed = settingsPressed
        
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
