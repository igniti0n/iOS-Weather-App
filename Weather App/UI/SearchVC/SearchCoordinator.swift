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

class SearchCoordinator : Coordinator {
    
    func start() -> UIViewController {
        let vc = createSearchVC()
       
        return vc
    }
    
   
    
    private func createSearchVC() -> UIViewController{
        let vc = SearchViewController()
        
        
        return vc
    }
    
  
    
}
