//
//  ActivityIndicatorProtocol.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/1/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import UIKit


/// Activity indicator protocol
protocol ActivityIndicator {
    var spinner: UIActivityIndicatorView { get }
}


// MARK: - Activity indicator protocol extension used to define default behavior of the protocol
extension ActivityIndicator where Self: UIViewController {
    
    func showIndicator() {
        spinner.startAnimating()
    }
    
    func hideIndicator() {
        updateUI {
            self.spinner.stopAnimating()
        }
    }
    
    func configureSpinner() {
        spinner.color = Constants.Colors.UdacityBlue
        spinner.hidesWhenStopped = true
        spinner.center = view.center
        view.addSubview(spinner)
    }

}
