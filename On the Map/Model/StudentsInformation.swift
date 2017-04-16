//
//  StudentsInformation.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 4/15/17.
//  Copyright © 2017 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

class StudentsInformation {
    
    static let sharedInstance = StudentsInformation()
    
    var students: [StudentInformation] {
        didSet {
            studentsFetched = true
        }
    }
    
    var studentsFetched = false
    var currentUserInformation: StudentInformation
    
    //Initialized currentUserInformation with empty dictionary
    //so all values are set to an empty string or 0 if is a float
    fileprivate init() {
        self.students = [StudentInformation]()
        self.currentUserInformation = StudentInformation(fromDictionary: [:])
    }
}
