//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 4/15/17.
//  Copyright © 2017 Santiago Avila Arroyave. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationViewController: UIViewController {

    
    @IBOutlet fileprivate weak var locationTextField: UITextField! {
        didSet {
            locationTextField.udacityField(withAutocorrection: true)
        }
    }
    
    @IBOutlet fileprivate weak var websiteTextField: UITextField! {
        didSet {
            websiteTextField.udacityField()
        }
    }
    
    @IBOutlet fileprivate weak var findLocationButton: UIButton! {
        didSet {
            findLocationButton.setTitle(Constants.Copy.findLocation, for: .normal)
            findLocationButton.udacityButton()
            findLocationButton.addTarget(self, action: #selector(findLocation), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCancelButton()
    }
    
    fileprivate func configureCancelButton() {
        let cancelButton = UIBarButtonItem(title: Constants.Copy.cancel, style: .plain, target: self, action: #selector(dismissView))
        cancelButton.setTitleTextAttributes([NSFontAttributeName: Appearance.Font.mediumRoboto(withSize: 16)], for: .normal)
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    func findLocation() {
        let location = locationTextField.text ?? ""
        let url = websiteTextField.text ?? ""
        
        if location.isEmpty {
            showAlert(withError: Constants.Error.noLocation)
        } else if url.isEmpty {
            showAlert(withError: Constants.Error.noWebsite)
        } else if !UIApplication.shared.canOpenURL(URL(string: url)!) {
            showAlert(withError: Constants.Error.invalidWebsite)
        } else {
            CLGeocoder().geocodeAddressString(location, completionHandler: { (placemarks, error) in
                print(placemarks!)
            })
        }
    }
    
    fileprivate func showAlert(withError error: String) {
        let alert = UIAlertController(title: Constants.Error.title, message: error, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: Constants.Copy.close, style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
}
