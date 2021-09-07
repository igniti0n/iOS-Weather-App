//
//  SearchCoordinator.swift
//  Weather App
//
//  Created by Ivan Stajcer on 02.09.2021..
//

import Foundation
import  UIKit


/*
 nisam dodao još funkcinalnosti, samo da se moze prikazati
 */

class SearchCoordinator: Coordinator {
    var onSearchWeatherFetch: ((Weather) -> Void)?
        
    func start() -> UIViewController {
        let vc = createSearchVC()
        return vc
    }
}

fileprivate extension SearchCoordinator {
    //MARK: - CREATING
    private func createSearchVC() -> UIViewController{
        let searchController = SearchViewController()
        let searchViewModel = SearchViewModel(networkWeatherService: ServiceFactory.networkWeatherService)
        searchViewModel.onFetchSucces = { [weak self] newWeather in
            DispatchQueue.main.async {
                self?.onSearchWeatherFetch?(newWeather)
            }
        }
        searchController.searchViewModel = searchViewModel
        return searchController
    }
}
    
    
  
    

