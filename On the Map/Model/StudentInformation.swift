//
//  StudentLocation.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/1/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import MapKit

struct StudentInformation {
    var objectId: String
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Float
    var longitude: Float
    var createdAt: String
    var updatedAt: String
    
    var fullName: String {
        get {
            return firstName + " " + lastName
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        }
    }
 
    init(fromDictionary dictionary: ResponseDictionary) {
        self.objectId = (dictionary[Constants.UdacityParseAPI.Key.objectId] as? String) ?? ""
        self.uniqueKey = (dictionary[Constants.UdacityParseAPI.Key.uniqueKey] as? String) ?? ""
        self.firstName = (dictionary[Constants.UdacityParseAPI.Key.firstName] as? String) ?? ""
        self.lastName = (dictionary[Constants.UdacityParseAPI.Key.lastName] as? String) ?? ""
        self.mapString = (dictionary[Constants.UdacityParseAPI.Key.mapString] as? String) ?? ""
        self.mediaURL = (dictionary[Constants.UdacityParseAPI.Key.mediaURL] as? String) ?? ""
        self.latitude = (dictionary[Constants.UdacityParseAPI.Key.latitude] as? Float) ?? 0
        self.longitude = (dictionary[Constants.UdacityParseAPI.Key.longitude] as? Float) ?? 0
        self.createdAt = (dictionary[Constants.UdacityParseAPI.Key.createdAt] as? String) ?? ""
        self.updatedAt = (dictionary[Constants.UdacityParseAPI.Key.updatedAt] as? String) ?? ""
    }
    
    func serialize() -> ResponseDictionary {
        var dictionary = ResponseDictionary()
        dictionary[Constants.UdacityParseAPI.Key.uniqueKey] = self.uniqueKey
        dictionary[Constants.UdacityParseAPI.Key.firstName] = self.firstName
        dictionary[Constants.UdacityParseAPI.Key.lastName] = self.lastName
        dictionary[Constants.UdacityParseAPI.Key.mapString] = self.mapString
        dictionary[Constants.UdacityParseAPI.Key.mediaURL] = self.mediaURL
        dictionary[Constants.UdacityParseAPI.Key.latitude] = self.latitude
        dictionary[Constants.UdacityParseAPI.Key.longitude] = self.longitude
        return dictionary
    }
}
