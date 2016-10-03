//
//  AppAppearance.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/2/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addGradient(withColors colors: [UIColor]) {
        backgroundColor = .orange
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.flatMap{ $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.addSublayer(gradientLayer)
    }
}
