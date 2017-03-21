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
        static let ApiScheme = "https://"
        static let CommonApiScheme = "http://"
        static let ApiHost = "www.udaciy.com/api"
        static let ApiLoginPath = "/session"
        static let SignUpURL = "https://www.udacity.com/account/auth#!/signup"
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
    
    // MARK: TMDB Parameter Keys
    struct TMDBParameterKeys {
        static let ApiKey = "api_key"
        static let RequestToken = "request_token"
        static let SessionID = "session_id"
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: TMDB Parameter Values
    struct TMDBParameterValues {
        static let ApiKey = "YOUR_API_KEY_HERE"
    }
    
    // MARK: TMDB Response Keys
    struct TMDBResponseKeys {
        static let Title = "title"
        static let ID = "id"
        static let PosterPath = "poster_path"
        static let StatusCode = "status_code"
        static let StatusMessage = "status_message"
        static let SessionID = "session_id"
        static let RequestToken = "request_token"
        static let Success = "success"
        static let UserID = "id"
        static let Results = "results"
    }
    
    struct Error {
        static let RequestFailed = "The request failed, try again."
        static let Title = "Error"
        static let InvalidCredentials = "Wrong email or password."
        static let NoData = "No data was returned by the request!"
        static let InvalidEmail = "Please enter a valid email address."
        static let NoPassword = "Please enter your password."
    }
    
    // MARK: UI
    struct Colors {
        static let UdacityOrange = UIColor(red: 255/255, green: 105/255, blue: 0/255, alpha: 1)
        static let UdacityOrangeButton = UIColor(red: 229/255, green: 83/255, blue: 0/255, alpha: 1)
        static let UdacityOrange60 =  Constants.Colors.UdacityOrange.withAlphaComponent(-1.0)
    }
    
    // MARK: Segues
    struct SegueIds {
        static let mapViewSegue = "ShowPins"
    }
    
    enum Copies: String {
        case Logout
        case Close
    }
}
