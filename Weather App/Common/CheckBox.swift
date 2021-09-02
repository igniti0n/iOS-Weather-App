//
//  CheckBox.swift
//  Weather App
//
//  Created by Ivan Stajcer on 02.09.2021..
//
import UIKit

class UICheckBox: UIButton {

    private var userDefaultsKey: String!
    private var isChecked: Bool!
    
    private weak var oppositeCheckbox: UICheckBox?

    required init(_ userDefaultsKey: String) {
        self.userDefaultsKey = userDefaultsKey
        self.isChecked = UserDefaults.standard.bool(forKey: userDefaultsKey)
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.backgroundColor = UIColor.white.cgColor
        self.addTarget(self, action: #selector(onCheckboxTap), for: .touchUpInside)
        
        updateImage()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onCheckboxTap(sender: UIButton) {
        flipState()
        oppositeCheckbox?.flipState()
    }
    
    public func setOpposite(_ opposite: UICheckBox) {
        self.oppositeCheckbox = opposite
    }
    
    private func flipState() {
        isChecked.toggle()
        UserDefaults.standard.set(isChecked, forKey: userDefaultsKey)
        UserDefaults.standard.synchronize()
        updateImage()
    }
    
    private func updateImage() {
        if isChecked {
            self.setImage(UIImage(named: "check")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            self.setImage(.none, for: .normal)
        }
    }
    
}

