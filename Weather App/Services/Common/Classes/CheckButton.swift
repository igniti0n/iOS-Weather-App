//
//  CheckBox.swift
//  Weather App
//
//  Created by Ivan Stajcer on 02.09.2021..
//
import UIKit

class CheckButton : UIButton {

    var isChecked: Bool {
        didSet {
            updateImage()
        }
    }
    private weak var oppositeCheckbox: CheckButton?

    required init( initialChecked: Bool) {
        self.isChecked = initialChecked
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
    
    public func setOpposite(_ opposite: CheckButton) {
        self.oppositeCheckbox = opposite
    }
    
    private func flipState() {
        isChecked.toggle()
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

