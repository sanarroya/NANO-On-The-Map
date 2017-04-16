//
//  StudentAnnotation.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 3/20/17.
//  Copyright © 2017 Santiago Avila Arroyave. All rights reserved.
//

import MapKit

class StudentAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(withStudent student: StudentInformation) {
        self.title = student.fullName
        self.subtitle = student.mediaURL
        self.coordinate = student.coordinate
    }
}
