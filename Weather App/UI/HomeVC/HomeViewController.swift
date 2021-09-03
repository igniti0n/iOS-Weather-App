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
        
        homeView.searchButtonPressed = {
            [weak self] in
            self?.homeViewModel.searchPressed?()
        }
        
        homeView.settingsButtonPressed = {
            [weak self] in
            self?.homeViewModel.settingsPressed?()
        }
       
    }

}
