//
//  Network.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/1/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

struct API {
    fileprivate var sharedSession = URLSession.shared
    
    func udacityLogin(parameters: [String: Any], success: @escaping (Data) -> (), failure: @escaping (_ failure: String) -> ()) {
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = dictionaryToJSON(params: parameters)
        requestAPI(withURLRequest: request, success: { data in
            success(data)
        }) { error in
            failure(error)
        }
    }
    
    fileprivate func requestAPI(withURLRequest url: URLRequest, success: @escaping (Data) -> (), failure: @escaping (_ failure: String) -> ()) {
        sharedSession.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                failure((error?.localizedDescription)!)
                return
            }
            print((response as? HTTPURLResponse)?.statusCode)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                failure(Constants.Error.RequestFailed)
                return
            }
            
            guard let data = data else {
                failure(Constants.Error.NoData)
                return
            }
            let newData = data.subdata(in: Range(uncheckedBounds: (lower: 5, upper: data.count)))
            print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue))
//            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
            success(newData)
        }.resume()
    }
    
    fileprivate func dictionaryToJSON(params: [String: Any]) -> Data {
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        print(jsonString)
        return jsonData
    }
}
