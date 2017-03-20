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

    func getStudentsLocations(success: @escaping ([StudentInformation]) -> (), failure: @escaping (String) -> ()) {
        let request = NSMutableURLRequest(url: URL(string: Constants.UdacityParseAPI.studentLocationEndpoint)!)
        addHeadersTo(request: request)
        requestAPI(withURLRequest: request as URLRequest, success: { data in
            let params = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
            success(self.parseStudentsLocationResponse(params as! [String : Any]))
        }) { error in
            failure(error)
        }
    }
    
    func addStudentLocation() {
        let request = NSMutableURLRequest(url: URL(string: Constants.UdacityParseAPI.studentLocationEndpoint)!)
        addHeadersTo(request: request)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
    }
    
    func updateStudentLocation() {
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation/8ZExGR5uX8"
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        addHeadersTo(request: request)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
    }
    
    fileprivate func addHeadersTo(request: NSMutableURLRequest) {
        request.addValue(Constants.UdacityParseAPI.Values.applicationID,
                         forHTTPHeaderField: Constants.UdacityParseAPI.Keys.parseApplicationId)
        request.addValue(Constants.UdacityParseAPI.Values.apiKey,
                         forHTTPHeaderField: Constants.UdacityParseAPI.Keys.parseRestAPIKey)

    }
    
    fileprivate func parseStudentsLocationResponse(_ params: [String : Any]) -> [StudentInformation] {
        var studentInformation = [StudentInformation]()
        let students = params["results"] as! [[String : Any]]
        for student in students {
            studentInformation.append(StudentInformation(fromDictionary: student))
        }
        
        return studentInformation
    }
}
