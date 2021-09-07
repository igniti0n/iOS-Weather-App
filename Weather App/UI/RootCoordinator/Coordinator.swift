//
//  Coordinator.swift
//  Weather App
//
//  Created by Ivan Stajcer on 31.08.2021..
//

import Foundation
import UIKit


public protocol Coordinator: Any {
    
    @discardableResult
    func start() -> UIViewController
    
}
