//
//  AppAppearance.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/2/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func udacityField() {
        layer.cornerRadius = 4
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
    }
}

extension UIButton {
    func udacityButton() {
        layer.cornerRadius = 4
        layer.borderColor = Constants.Colors.UdacityBlue.cgColor
        layer.borderWidth = 1
    }
}
