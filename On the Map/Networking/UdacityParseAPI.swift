//
//  UdacityParseAPI.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/1/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

struct ParseAPI: APIHelperProtocol {
    
    var sharedSession = URLSession.shared

    func getStudentsLocations(success: @escaping ([StudentInformation]) -> (), failure: @escaping ErrorBlock) {
        var request = URLRequest(url: URL(string: Constants.UdacityParseAPI.studentLocationEndpoint)!)
        addHeadersTo(request: &request)
        requestAPI(withURLRequest: request as URLRequest, success: { data in
            let params = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
            success(self.parseStudentsLocationResponse(params as! ResponseDictionary))
        }) { error in
            failure(error)
        }
    }
    
    func addStudentLocation(student: ResponseDictionary, success: @escaping ([StudentInformation]) -> (), failure: @escaping ErrorBlock) {
        var request = URLRequest(url: URL(string: Constants.UdacityParseAPI.studentLocationEndpoint)!)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = dictionaryToJSON(params: student)
        addHeadersTo(request: &request)
        requestAPI(withURLRequest: request, success: { data in
            
        }) { error in
            
        }
    }
    
    fileprivate func addHeadersTo( request: inout URLRequest) {
        request.setValue(Constants.UdacityParseAPI.Value.applicationID, forHTTPHeaderField: Constants.UdacityParseAPI.Key.parseApplicationId)
        request.setValue(Constants.UdacityParseAPI.Value.apiKey, forHTTPHeaderField: Constants.UdacityParseAPI.Key.parseRestAPIKey)
        request.setValue(Constants.Udacity.Value.applicationJSON, forHTTPHeaderField: Constants.Udacity.Key.contentType)
    }
    
    fileprivate func parseStudentsLocationResponse(_ response: ResponseDictionary) -> [StudentInformation] {
        var studentInformation = [StudentInformation]()
        let students = response[Constants.UdacityParseAPI.Key.results] as! [ResponseDictionary]
        for student in students {
            studentInformation.append(StudentInformation(fromDictionary: student))
        }
        
        return studentInformation
    }
}
