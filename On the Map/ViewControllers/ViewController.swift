//
//  ViewController.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/1/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ActivityIndicator {

    let api = API()
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
    
    @IBOutlet fileprivate weak var emailTextField: UITextField! {
        didSet {
            emailTextField.keyboardType = .emailAddress
            emailTextField.autocorrectionType = .no
            emailTextField.autocapitalizationType = .none
        }
    }
    
    @IBOutlet fileprivate weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
            passwordTextField.autocorrectionType = .no
            passwordTextField.autocapitalizationType = .none
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.UdacityOrange
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func loginAction() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if !Validator.validateEmail(email) {
            print(email)
        } else if password.isEmpty {
            print(password)
        } else {
            showIndicator()
            let parameters = ["udacity": ["username": email, "password": password]]
            api.udacityLogin(parameters: parameters, success: { data in
                let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
            }, failure: { error in
                print(error)
            })
        }
    }
}

