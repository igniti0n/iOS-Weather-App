//
//  NavigationBarExtension.swift
//  Weather App
//
//  Created by Ivan Stajcer on 02.09.2021..
//
import UIKit

extension UINavigationBar {
  func setTransparent() {
    self.setBackgroundImage(UIImage(), for: .default)
    self.shadowImage = UIImage()
    self.isTranslucent = true
  }
  func setOpaque() {
    self.setBackgroundImage(nil, for: .default)
    self.shadowImage = nil
    self.isTranslucent = false
  }
}
