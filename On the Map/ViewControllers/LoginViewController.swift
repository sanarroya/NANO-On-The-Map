//
//  ViewController.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/1/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, ActivityIndicator {

    fileprivate let api = API()
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet fileprivate weak var loginButton: UIButton! {
        didSet {
            loginButton.setTitle(Constants.Copy.login, for: .normal)
            loginButton.udacityButton()
            loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet fileprivate weak var signUpButton: UIButton! {
        didSet {
            let noAccountAttributes: [String : Any] = [NSFontAttributeName: Appearance.Font.regularRoboto(),
                                                       NSForegroundColorAttributeName: UIColor.black]
            let signUpAttributes: [String : Any] = [NSFontAttributeName: Appearance.Font.regularRoboto(),
                                                    NSForegroundColorAttributeName: Appearance.Colors.udacityBlue]
            
            let noAccountCopy = NSMutableAttributedString(string: Constants.Copy.noAccount, attributes: noAccountAttributes)
            let signUpCopy = NSAttributedString(string: Constants.Copy.signUp, attributes: signUpAttributes)
            noAccountCopy.append(signUpCopy)
            signUpButton.setAttributedTitle(noAccountCopy, for: .normal)
            signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet fileprivate weak var emailTextField: UITextField! {
        didSet {
            emailTextField.keyboardType = .emailAddress
            emailTextField.udacityField()
        }
    }
    
    @IBOutlet fileprivate weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
            passwordTextField.udacityField()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSpinner()
    }
    
    func loginAction() {
        updateLoginButtonState()
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if !Validator.validateEmail(email) {
            updateLoginButtonState()
            showAlert(withError: Constants.Error.invalidEmail)
        } else if password.isEmpty {
            updateLoginButtonState()
            showAlert(withError: Constants.Error.noPassword)
        } else {
            showIndicator()
            
            let parameters = [Constants.Udacity.Key.udacity:
                [Constants.Udacity.Key.username: email,
                 Constants.Udacity.Key.password: password]]
            
            dispatchOnBackground { [weak self] void in
                guard let strongself = self else { return }
                strongself.api.udacityLogin(parameters: parameters, success: { data in
                    strongself.hideIndicator()
                    updateUI {
                        strongself.updateLoginButtonState()
                        strongself.clearFields()
                        strongself.performSegue(withIdentifier: Constants.SegueIds.mapViewSegue, sender: nil)
                    }
                }, failure: { error in
                    guard let strongself = self else { return }
                    strongself.hideIndicator()
                    updateUI {
                        strongself.updateLoginButtonState()
                        strongself.showAlert(withError: error)
                    }
                })
            }
        }
    }
    
    func signUpAction() {
        UIApplication.shared.open(URL(string: Constants.Udacity.signUpURL)!, options: [:], completionHandler: nil)
    }
    
    fileprivate func updateLoginButtonState() {
        loginButton.isEnabled = !loginButton.isEnabled
        signUpButton.isEnabled = !signUpButton.isEnabled
        loginButton.alpha = loginButton.isEnabled ? 1.0 : 0.3
    }
    
    fileprivate func clearFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}
