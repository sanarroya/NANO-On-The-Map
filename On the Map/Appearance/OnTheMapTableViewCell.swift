//
//  OnTheMapTableViewCell.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 4/15/17.
//  Copyright © 2017 Santiago Avila Arroyave. All rights reserved.
//

import UIKit

class OnTheMapTableViewCell: UITableViewCell {

    func configureCell(withStudent student: StudentInformation) -> UITableViewCell {
        textLabel?.text = student.fullName
        detailTextLabel?.text = student.mediaURL
        detailTextLabel?.textColor = .lightGray
        imageView?.image = #imageLiteral(resourceName: "icon_pin")
        return self
    }

}
