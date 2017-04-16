//
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/1/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

struct API: APIHelperProtocol {
    
    var sharedSession = URLSession.shared
    
    func udacityLogin(parameters: ResponseDictionary, success: @escaping SuccessEmptyBlock, failure: @escaping ErrorBlock) {
        var request = URLRequest(url: URL(string: Constants.Udacity.loginEndpoint)!)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.addValue(Constants.Udacity.Value.applicationJSON, forHTTPHeaderField: Constants.Udacity.Key.accept)
        request.addValue(Constants.Udacity.Value.applicationJSON, forHTTPHeaderField: Constants.Udacity.Key.contentType)
        request.httpBody = dictionaryToJSON(params: parameters)
        requestAPI(withURLRequest: request, success: { data in
            let jsonResponse = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let userId = self.parseLoginResponse(jsonResponse as! ResponseDictionary)
            self.getPublicUserData(withUserId: userId, success: { 
                success()
            }, failure: { error in
                failure(error)
            })
        }) { error in
            failure(error)
        }
    }
    
    func udacityLogout(success: @escaping SuccessEmptyBlock, failure: @escaping ErrorBlock) {
        var request = URLRequest(url: URL(string: Constants.Udacity.loginEndpoint)!)
        request.httpMethod = HTTPMethod.DELETE.rawValue
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == Constants.Udacity.Key.xsrfToken { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: Constants.Udacity.Key.xxsrfToken)
        }
        
        requestAPI(withURLRequest: request, success: { data in
            success()
        }) { error in
            failure(error)
        }
    }
    
    fileprivate func getPublicUserData(withUserId userId: String, success: @escaping SuccessEmptyBlock, failure: @escaping ErrorBlock) {
        let urlString = Constants.Udacity.userDataEndpoint.replacingOccurrences(of: Constants.Udacity.Key.userIdPlaceHolder, with: userId)
        let request = URLRequest(url: URL(string: urlString)!)
        requestAPI(withURLRequest: request, success: { data in
            let jsonResponse = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! ResponseDictionary
            self.parsePublicUserDataResponse(jsonResponse)
            success()
        }) { error in
            failure(error)
        }
    }
    
    fileprivate func parseLoginResponse(_ response: ResponseDictionary) -> String {
        let account = response[Constants.Udacity.Key.account] as! ResponseDictionary
        let uniqueId = account[Constants.Udacity.Key.key] as! String
        StudentsInformation.sharedInstance.currentUserInformation.uniqueKey = uniqueId
        return uniqueId
    }
    
    fileprivate func parsePublicUserDataResponse(_ response: ResponseDictionary) {
        let user = response[Constants.Udacity.Key.user] as! ResponseDictionary
        StudentsInformation.sharedInstance.currentUserInformation.firstName = user[Constants.Udacity.Key.firstName] as! String
        StudentsInformation.sharedInstance.currentUserInformation.lastName = user[Constants.Udacity.Key.lastName] as! String
    }
    
}
