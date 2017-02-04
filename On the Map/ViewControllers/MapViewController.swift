//
//  MapViewController.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 2/1/17.
//  Copyright © 2017 Santiago Avila Arroyave. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, ActivityIndicator {

    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet fileprivate weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    fileprivate func configureButtons() {
        let logoutButton = UIBarButtonItem(title: Constants.Copies.Logout.rawValue, style: .plain, target: self, action: #selector(logout))
        let pinButton = UIBarButtonItem(image: #imageLiteral(resourceName: "pin"), style: .plain, target: self, action: #selector(location))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItems = [refreshButton, pinButton]
    }
    
    func logout() {
        dismiss(animated: true, completion: nil)
    }
    
    func refresh() {
        
    }
    
    func location() {
    }


}
