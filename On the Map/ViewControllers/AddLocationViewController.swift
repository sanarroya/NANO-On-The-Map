//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 4/15/17.
//  Copyright © 2017 Santiago Avila Arroyave. All rights reserved.
//

import UIKit

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
        
    }
}
