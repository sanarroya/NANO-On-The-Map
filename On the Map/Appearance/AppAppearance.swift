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
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        leftViewMode = .always
    }
}

extension UIButton {
    func udacityButton() {
        layer.cornerRadius = 4
        layer.borderColor = Appearance.Colors.udacityBlue.cgColor
        layer.borderWidth = 1
    }
}

struct Appearance {
    static func onTheMapNavBar() {
        UINavigationBar.appearance().tintColor = Appearance.Colors.udacityBlue
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: Font.mediumRoboto(withSize: 16)]
    }
    
    struct Colors {
        static let udacityBlue = UIColor(red: 2/255, green: 179/255, blue: 228/255, alpha: 1)
    }
    
    struct Font {
        static func thinRoboto(withSize size: CGFloat = 18) -> UIFont {
            return UIFont(name: Constants.Font.robotoThin, size: size)!
        }
        
        static func regularRoboto(withSize size: CGFloat = 15) -> UIFont {
            return UIFont(name: Constants.Font.robotoRegular, size: size)!
        }
        
        static func mediumRoboto(withSize size: CGFloat = 18) -> UIFont {
            return UIFont(name: Constants.Font.robotoMedium, size: size)!
        }
    }
}
