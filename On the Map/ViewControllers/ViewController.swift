//
//  ViewController.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/1/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ActivityIndicator {

    fileprivate let api = API()
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet fileprivate weak var loginButton: UIButton! {
        didSet {
            loginButton.backgroundColor = Constants.Colors.UdacityOrangeButton
            loginButton.setTitle("Login", for: .normal)
            loginButton.titleLabel?.font = UIFont(name: "Roboto-Medium.ttf", size: 20.0)
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet fileprivate weak var signUpButton: UIButton! {
        didSet {
            signUpButton.titleLabel?.font = UIFont(name: "Roboto-Medium.ttf", size: 20.0)
            signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet fileprivate weak var emailTextField: UITextField! {
        didSet {
            emailTextField.keyboardType = .emailAddress
            emailTextField.autocorrectionType = .no
            emailTextField.autocapitalizationType = .none
            emailTextField.textColor = .lightGray
            emailTextField.text = "sanarroya@gmail.com"
        }
    }
    
    @IBOutlet fileprivate weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
            passwordTextField.autocorrectionType = .no
            passwordTextField.autocapitalizationType = .none
            passwordTextField.textColor = .lightGray
            passwordTextField.text = "ogaitnas910112"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSpinner()
//        view.backgroundColor = Constants.Colors.UdacityOrange
    }
    
    @objc fileprivate func loginAction() {
        updateLoginButtonState()
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if !Validator.validateEmail(email) {
            updateLoginButtonState()
        } else if password.isEmpty {
            updateLoginButtonState()
        } else {
            showIndicator()
            let parameters = ["udacity": ["username": email, "password": password]]
            dispatchOnBackground { [weak self] void in
                guard let strongSelf = self else { print("hp");return }
                strongSelf.api.udacityLogin(parameters: parameters, success: { data in
                    let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    strongSelf.hideIndicator()
                    updateUI {
                        strongSelf.performSegue(withIdentifier: Constants.SegueIds.mapViewSegue, sender: nil)
                    }
                    }, failure: { error in
                        guard let strongSelf = self else { return }
                        print(error)
                        strongSelf.hideIndicator()
                        updateUI {
                            strongSelf.updateLoginButtonState()
                        }
                })
            }
        }
    }
    
    @objc fileprivate func signUpAction() {
        UIApplication.shared.open(URL(string: Constants.Udacity.SignUpURL)!, options: [:], completionHandler: nil)
    }
    
    fileprivate func updateLoginButtonState() {
        loginButton.isEnabled = !loginButton.isEnabled
    }
}

