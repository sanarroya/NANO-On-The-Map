//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 4/15/17.
//  Copyright © 2017 Santiago Avila Arroyave. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationViewController: UIViewController, ActivityIndicator {

    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
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
        configureSpinner()
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
        showIndicator()
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
                self.hideIndicator()
                guard error == nil else {
                    self.showAlert(withError: (error?.localizedDescription)!)
                    return
                }
                guard let place = placemarks?[0], let placeLocation = place.location else { return }
                StudentsInformation.sharedInstance.currentUserInformation.mediaURL = url
                StudentsInformation.sharedInstance.currentUserInformation.mapString = location
                StudentsInformation.sharedInstance.currentUserInformation.latitude = Float(placeLocation.coordinate.latitude)
                StudentsInformation.sharedInstance.currentUserInformation.longitude = Float(placeLocation.coordinate.longitude)
                self.performSegue(withIdentifier: Constants.SegueIds.confirmLocationSegue, sender: nil)
            })
        }
    }
}
