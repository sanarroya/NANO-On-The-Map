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
        spinner.color = Appearance.Colors.udacityBlue
        spinner.hidesWhenStopped = true
        spinner.center = view.center
        view.addSubview(spinner)
    }
    
    func showAlert(withError error: String) {
        let alert = UIAlertController(title: Constants.Error.title, message: error, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: Constants.Copy.close, style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
}
