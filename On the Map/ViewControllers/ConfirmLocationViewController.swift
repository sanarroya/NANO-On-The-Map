//
//  ConfirmLocationViewController.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 4/15/17.
//  Copyright © 2017 Santiago Avila Arroyave. All rights reserved.
//

import UIKit
import MapKit

class ConfirmLocationViewController: UIViewController, ActivityIndicator {

    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton! {
        didSet {
            finishButton.setTitle(Constants.Copy.finish, for: .normal)
            finishButton.udacityButton()
            finishButton.addTarget(self, action: #selector(postLocation), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureSpinner()
        configureCancelButton()
        addAnnotationToMap()
    }
    
    fileprivate func configureCancelButton() {
        let cancelButton = UIBarButtonItem(title: Constants.Copy.cancel, style: .plain, target: self, action: #selector(dismissView))
        cancelButton.setTitleTextAttributes([NSFontAttributeName: Appearance.Font.mediumRoboto(withSize: 16)], for: .normal)
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    fileprivate func addAnnotationToMap() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = StudentsInformation.sharedInstance.currentUserInformation.coordinate
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, Constants.Map.regionMeters, Constants.Map.regionMeters)
        mapView.addAnnotation(annotation)
        mapView.region = mapView.regionThatFits(region)
    }

    func dismissView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func postLocation() {
        showIndicator()
        let student = StudentsInformation.sharedInstance.currentUserInformation.serialize()
        dispatchOnBackground {
            ParseAPI().addStudentLocation(student: student, success: { [weak self] _ in
                guard let strongself = self else { return }
                StudentsInformation.sharedInstance.studentsFetched = false
                updateUI {
                    strongself.hideIndicator()
                    strongself.dismissView()
                }
            }) { [weak self] error in
                guard let strongself = self else { return }
                updateUI {
                    strongself.hideIndicator()
                    strongself.showAlert(withError: error)
                }
            }
        }
    }
}

extension ConfirmLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = Constants.Map.pinId
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = false
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation, var urlString = annotation.subtitle ?? nil else { return }
        if !(urlString.contains(Constants.Udacity.apiScheme)) && !(urlString.contains(Constants.Udacity.commonApiScheme)) {
            urlString = Constants.Udacity.commonApiScheme + urlString
        }
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
