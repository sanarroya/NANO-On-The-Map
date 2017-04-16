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
    
    struct Udacity {
        static let apiScheme = "https://"
        static let commonApiScheme = "http://"
        static let apiHost = "www.udacity.com/api"
        static let apiLoginPath = "/session"
        static let apiUserDataPath = "/users/{userId}"
        static let signUpURL = "https://www.udacity.com/account/auth#!/signup"
        static let loginEndpoint = apiScheme + apiHost + apiLoginPath
        static let userDataEndpoint = apiScheme + apiHost + apiUserDataPath
        
        struct Key {
            static let accept = "Accept"
            static let contentType = "Content-Type"
            static let xxsrfToken = "X-XSRF-TOKEN"
            static let xsrfToken = "XSRF-TOKEN"
            static let udacity = "udacity"
            static let username = "username"
            static let password = "password"
            static let userIdPlaceHolder = "{userId}"
            static let user = "user"
            static let account = "account"
            static let key = "key"
            static let firstName = "first_name"
            static let lastName = "last_name"
        }
        
        struct Value {
            static let applicationJSON = "application/json"
        }
    }
    
    struct UdacityParseAPI {
        static let baseURL = "https://parse.udacity.com/parse/classes"
        static let studentLocationEndpoint = baseURL + "/StudentLocation"
        
        struct Key {
            static let parseApplicationId = "X-Parse-Application-Id"
            static let parseRestAPIKey = "X-Parse-REST-API-Key"
            static let results = "results"
            static let objectId = "objectId"
            static let uniqueKey = "uniqueKey"
            static let firstName = "firstName"
            static let lastName = "lastName"
            static let mapString = "mapString"
            static let mediaURL = "mediaURL"
            static let latitude = "latitude"
            static let longitude = "longitude"
            static let createdAt = "createdAt"
            static let updatedAt = "updatedAt"
        }
        
        struct Value {
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
        static let noLocation = "Must enter a location"
        static let noWebsite = "Must enter a website"
        static let invalidWebsite = "Invalid Link. Include http(s)://."
        static let problemFetchingStudents = "Please try again later, there is a problem fetching the students"
        static let logoutFailed = "Please try to logout again later"
    }
    
    struct Font {
        static let robotoThin = "Roboto-Thin"
        static let robotoRegular = "Roboto-Regular"
        static let robotoMedium = "Roboto-Medium"
    }
    
    struct SegueIds {
        static let mapViewSegue = "ShowPins"
        static let addLocationSegue = "AddLocation"
        static let confirmLocationSegue = "ConfirmLocation"
    }
    
    struct Copy {
        static let login = "LOGIN"
        static let logout = "Logout"
        static let close = "Close"
        static let noAccount = "Don't have an account? "
        static let signUp = "Sign Up"
        static let cancel = "Cancel"
        static let findLocation = "FIND LOCATION"
        static let finish = "FINISH"
    }
    
    struct Map {
        static let pinId = "pin"
        static let regionMeters: Double = 1000
    }
}
