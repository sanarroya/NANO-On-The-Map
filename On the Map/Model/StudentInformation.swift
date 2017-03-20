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
 
    init(fromDictionary dictionary: [String : Any]) {
        self.objectId = (dictionary["objectId"] ?? "") as! String
        self.uniqueKey = (dictionary["uniqueKey"] ?? "") as! String
        self.firstName = (dictionary["firstName"] ?? "") as! String
        self.lastName = (dictionary["lastName"] ?? "") as! String
        self.mapString = (dictionary["mapString"] ?? "") as! String
        self.mediaURL = (dictionary["mediaURL"] ?? "") as! String
        self.latitude = (dictionary["latitude"] ?? "") as! Float
        self.longitude = (dictionary["longitude"] ?? "") as! Float
        self.createdAt = (dictionary["createdAt"] ?? "") as! String
        self.updatedAt = (dictionary["updatedAt"] ?? "") as! String
    }
}
