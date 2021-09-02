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
       
    }
    
    private func addCallbacks(){
        
        homeView.searchButtonPressed = searchPressed
        homeView.settingsButtonPressed = settingsPressed
    }

}
