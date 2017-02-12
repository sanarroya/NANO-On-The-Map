//
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/1/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

struct API: APIHelperProtocol {
    fileprivate let kLoginEndpoint = "https://www.udacity.com/api/session"
    fileprivate let kLogoutEndpoint = "https://www.udacity.com/api/session"
    fileprivate let kGetUserDataEndpoint = "https://www.udacity.com/api/users/3903878747"
    
    var sharedSession = URLSession.shared
    
    func udacityLogin(parameters: [String: Any], success: @escaping (Data) -> (), failure: @escaping (_ failure: String) -> ()) {
        var request = URLRequest(url: URL(string: kLoginEndpoint)!)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = dictionaryToJSON(params: parameters)
        requestAPI(withURLRequest: request, success: { data in
            success(data)
        }) { error in
            failure(error)
        }
    }
    
    func udacityLogout() {
        let request = NSMutableURLRequest(url: URL(string: kLogoutEndpoint)!)
        request.httpMethod = HTTPMethod.DELETE.rawValue
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = Range(uncheckedBounds: (5, data!.count - 5))
            let newData = data?.subdata(in: range) /* subset response data! */
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
    }
    
    func getUserData() {
        let request = NSMutableURLRequest(url: URL(string: kGetUserDataEndpoint)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let range = Range(uncheckedBounds: (5, data!.count - 5))
            let newData = data?.subdata(in: range) /* subset response data! */
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
    }
    
}
