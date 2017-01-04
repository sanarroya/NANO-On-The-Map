//
//  Validator.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 10/2/16.
//  Copyright © 2016 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

private let kEmailRegex = "[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+"

extension String {
    var isEmailvalid: Bool {
        let regex = try! NSRegularExpression(pattern: kEmailRegex, options: [])
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) != nil
    }
}

struct Validator {
    static func validateEmail(_ email: String) -> Bool {
        var isEmailValid = true
        isEmailValid = isEmailValid && !email.isEmpty
        isEmailValid = isEmailValid && email.isEmailvalid
        return isEmailValid
    }
}
