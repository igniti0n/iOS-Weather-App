//
//  TextFieldPadding.swift
//  Weather App
//
//  Created by Ivan Stajcer on 02.09.2021..
//

import Foundation
import UIKit

class TextFieldPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 4,
        left: 4,
        bottom: 4,
        right: 4
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
