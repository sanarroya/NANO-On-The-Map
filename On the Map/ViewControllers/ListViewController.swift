//
//  ListViewController.swift
//  On the Map
//
//  Created by Santiago Avila Arroyave on 2/1/17.
//  Copyright © 2017 Santiago Avila Arroyave. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, ActivityIndicator {

    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    var students: [StudentInformation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudents()
    }

    fileprivate func configureButtons() {
        let logoutButton = UIBarButtonItem(title: Constants.Copies.Logout.rawValue, style: .plain, target: self, action: #selector(logout))
        let pinButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_addpin"), style: .plain, target: self, action: #selector(location))
        let refreshButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_refresh"), style: .plain, target: self, action: #selector(refresh))
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItems = [pinButton, refreshButton]
    }
    
    func logout() {
        dismiss(animated: true, completion: nil)
    }
    
    func refresh() {
        students.removeAll()
        fetchStudents()
    }
    
    func location() {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    fileprivate func fetchStudents() {
        dispatchOnBackground {
            ParseAPI().getStudentsLocations(success: { [weak self] students in
                updateUI {
                    guard let strongself = self else { return }
                    strongself.students = students
                    
                }
                }, failure: { error in
                    
            })
        }
    }

}
