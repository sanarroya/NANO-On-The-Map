//
//  HTTPMethod.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 1/3/17.
//  Copyright © 2017 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

typealias ResponseDictionary = [String: Any]

enum HTTPMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
}

protocol APIHelperProtocol {
    typealias SuccessEmptyBlock = () -> ()
    typealias ErrorBlock = (String) -> ()
    var sharedSession: URLSession {get}
    func dictionaryToJSON(params: ResponseDictionary) -> Data
    func requestAPI(withURLRequest url: URLRequest, success: @escaping (Data) -> (), failure: @escaping ErrorBlock)
}

extension APIHelperProtocol {
    func dictionaryToJSON(params: ResponseDictionary) -> Data {
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        return jsonData
    }
    
    func requestAPI(withURLRequest url: URLRequest, success: @escaping (Data) -> (), failure: @escaping ErrorBlock) {
        sharedSession.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                failure((error?.localizedDescription)!)
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if statusCode == 403 {
                failure(url.isParseRequest ? Constants.Error.problemFetchingStudents : Constants.Error.invalidCredentials)
                return
            }else if statusCode! < 200 && statusCode! > 299 {
                failure(Constants.Error.requestFailed)
                return
            }
            
            guard let data = data else {
                failure(Constants.Error.noData)
                return
            }
            
            if !url.isParseRequest {
                let newData = data.subdata(in: Range(5..<data.count))
                success(newData)
            }else {
                success(data)
            }
            
            
        }.resume()
    }
}

extension URLRequest {
    var isParseRequest: Bool {
        get {
            guard let url = self.url else {
                return false
            }
            return url.absoluteString.contains(Constants.UdacityParseAPI.baseURL)
        }
    }
}
