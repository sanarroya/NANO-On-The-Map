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
    var annotations: [StudentAnnotation]!
    
    @IBOutlet fileprivate weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        configureButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStudents()
    }
    
    fileprivate func configureButtons() {
        let logoutButton = UIBarButtonItem(title: Constants.Copy.logout, style: .plain, target: self, action: #selector(logout))
        logoutButton.setTitleTextAttributes([NSFontAttributeName: Appearance.Font.mediumRoboto(withSize: 16)], for: .normal)
        let pinButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_addpin"), style: .plain, target: self, action: #selector(addLocation))
        let refreshButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_refresh"), style: .plain, target: self, action: #selector(refresh))
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItems = [pinButton, refreshButton]
    }
    
    func logout() {
        dismiss(animated: true, completion: nil)
    }
    
    func refresh() {
        mapView.removeAnnotations(annotations)
        annotations.removeAll()
        fetchStudents()
    }
    
    func addLocation() {
        performSegue(withIdentifier: Constants.SegueIds.addLocationSegue, sender: nil)
    }
    
    fileprivate func configureAnnotations(withStudents students: [StudentInformation]) -> [StudentAnnotation] {
        var annotations = [StudentAnnotation]()
        for student in students {
            annotations.append(StudentAnnotation(withStudent: student))
        }
        return annotations
    }

    fileprivate func fetchStudents() {
        dispatchOnBackground {
            ParseAPI().getStudentsLocations(success: { [weak self] students in
                updateUI {
                    guard let strongself = self else { return }
                    strongself.annotations = strongself.configureAnnotations(withStudents: students)
                    strongself.mapView.addAnnotations(strongself.annotations)
                }
                }, failure: { error in
                    
            })
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? StudentAnnotation {
            let kIdentifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: kIdentifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: kIdentifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
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
