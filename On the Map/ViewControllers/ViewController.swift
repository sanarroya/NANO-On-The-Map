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
            loginButton.backgroundColor = Constants.Colors.UdacityBlue
            loginButton.setTitle("Login", for: .normal)
            loginButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.udacityButton()
            loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet fileprivate weak var signUpButton: UIButton! {
        didSet {
            signUpButton.setTitleColor(Constants.Colors.UdacityBlue, for: .normal)
            signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
            signUpButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 15)

        }
    }
    
    @IBOutlet fileprivate weak var emailTextField: UITextField! {
        didSet {
            emailTextField.keyboardType = .emailAddress
            emailTextField.autocorrectionType = .no
            emailTextField.autocapitalizationType = .none
            emailTextField.textColor = .lightGray
            emailTextField.udacityField()
            emailTextField.text = "sanarroya@gmail.com"
        }
    }
    
    @IBOutlet fileprivate weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
            passwordTextField.autocorrectionType = .no
            passwordTextField.autocapitalizationType = .none
            passwordTextField.textColor = .lightGray
            passwordTextField.udacityField()
            passwordTextField.text = "ogaitnas910112"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSpinner()
    }
    
    @objc fileprivate func loginAction() {
        updateLoginButtonState()
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if !Validator.validateEmail(email) {
            updateLoginButtonState()
            showAlert(withError: Constants.Error.InvalidEmail)
        } else if password.isEmpty {
            updateLoginButtonState()
            showAlert(withError: Constants.Error.NoPassword)
        } else {
            showIndicator()
            let parameters = ["udacity": ["username": email, "password": password]]
            dispatchOnBackground { [weak self] void in
                guard let strongSelf = self else { print("hp");return }
                strongSelf.api.udacityLogin(parameters: parameters, success: { data in
                    strongSelf.hideIndicator()
                    updateUI {
                        strongSelf.updateLoginButtonState()
                        strongSelf.clearFields()
                        strongSelf.performSegue(withIdentifier: Constants.SegueIds.mapViewSegue, sender: nil)
                    }
                    }, failure: { error in
                        guard let strongSelf = self else { return }
                        strongSelf.hideIndicator()
                        updateUI {
                            strongSelf.updateLoginButtonState()
                            strongSelf.showAlert(withError: error)
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
        loginButton.alpha = loginButton.isEnabled ? 1.0 : 0.3
    }
    
    fileprivate func showAlert(withError error: String) {
        let alert = UIAlertController(title: Constants.Error.Title, message: error, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: Constants.Copies.Close.rawValue, style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func clearFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}
