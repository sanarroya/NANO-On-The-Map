//
//  Constants.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/1/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    // MARK: TMDB
    struct Udacity {
        static let apiScheme = "https://"
        static let commonApiScheme = "http://"
        static let apiHost = "www.udaciy.com/api"
        static let apiLoginPath = "/session"
        static let signUpURL = "https://www.udacity.com/account/auth#!/signup"
    }
    
    struct UdacityParseAPI {
        static let baseURL = "https://parse.udacity.com/parse/classes"
        static let studentLocationEndpoint = baseURL + "/StudentLocation"
        
        struct Keys {
            static let parseApplicationId = "X-Parse-Application-Id"
            static let parseRestAPIKey = "X-Parse-REST-API-Key"
        }
        
        struct Values {
            static let applicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
            static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        }
    }
    
    struct Error {
        static let requestFailed = "The request failed, try again."
        static let title = "Error"
        static let invalidCredentials = "Wrong email or password."
        static let noData = "No data was returned by the request!"
        static let invalidEmail = "Please enter a valid email address."
        static let noPassword = "Please enter your password."
    }
    
    struct Font {
        static let robotoThin = "Roboto-Thin"
        static let robotoRegular = "Roboto-Regular"
        static let robotoMedium = "Roboto-Medium"
    }
    
    // MARK: Segues
    struct SegueIds {
        static let mapViewSegue = "ShowPins"
    }
    
    enum Copy: String {
        case login = "Login"
        case logout = "Logout"
        case close = "Close"
        case noAccount = "Don't have an account? "
        case signUp = "Sign Up"
    }
}
