//
//  SearchCoordinator.swift
//  Weather App
//
//  Created by Ivan Stajcer on 02.09.2021..
//

import Foundation
import  UIKit

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
