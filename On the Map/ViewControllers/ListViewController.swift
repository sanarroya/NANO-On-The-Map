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
    var students = [StudentInformation]()
    let cellIdentifier = "StudentCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSpinner()
        configureButtons()
        fetchStudents()
    }

    fileprivate func configureButtons() {
        let logoutButton = UIBarButtonItem(title: Constants.Copy.logout.rawValue, style: .plain, target: self, action: #selector(logout))
        logoutButton.setTitleTextAttributes([NSFontAttributeName: Appearance.Font.mediumRoboto(withSize: 16)], for: .normal)
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! OnTheMapTableViewCell
        return cell.configureCell(withStudent: students[indexPath.row])
    }

    fileprivate func fetchStudents() {
        showIndicator()
        dispatchOnBackground {
            ParseAPI().getStudentsLocations(success: { [weak self] students in
                updateUI {
                    guard let strongself = self else { return }
                    strongself.students = students
                    strongself.tableView.reloadData()
                    strongself.hideIndicator()
                }
            }, failure: { error in
                    
            })
        }
    }

}
