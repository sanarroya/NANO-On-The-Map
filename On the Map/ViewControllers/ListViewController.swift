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
        tableView.tableFooterView = UIView()
        configureSpinner()
        configureButtons()
        fetchStudents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStudents()
    }

    fileprivate func configureButtons() {
        let logoutButton = UIBarButtonItem(title: Constants.Copy.logout, style: .plain, target: self, action: #selector(logout))
        logoutButton.setTitleTextAttributes([NSFontAttributeName: Appearance.Font.mediumRoboto(withSize: 16)], for: .normal)
        let pinButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_addpin"), style: .plain, target: self, action: #selector(addLocation))
        let refreshButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_refresh"), style: .plain, target: self, action: #selector(refresh))
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItems = [pinButton, refreshButton]
    }
    
    func logout() {
        dispatchOnBackground {
            API().udacityLogout(success: { [weak self] in
                guard let strongself = self else { return }
                updateUI {
                    strongself.dismiss(animated: true, completion: nil)
                }
            }) { error in
            }
        }
    }
    
    func refresh() {
        students.removeAll()
        fetchStudents()
    }
    
    func addLocation() {
        performSegue(withIdentifier: Constants.SegueIds.addLocationSegue, sender: nil)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let student = students[indexPath.row]
        var urlString = student.mediaURL
        cell?.setSelected(false, animated: true)
        if !(urlString.contains(Constants.Udacity.apiScheme)) && !(urlString.contains(Constants.Udacity.commonApiScheme)) {
            urlString = Constants.Udacity.commonApiScheme + student.mediaURL
        }
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    fileprivate func fetchStudents() {
        if !StudentsInformation.sharedInstance.studentsFetched {
            showIndicator()
            dispatchOnBackground {
                ParseAPI().getStudentsLocations(success: { [weak self] students in
                    guard let strongself = self else { return }
                    updateUI {
                        StudentsInformation.sharedInstance.students = students
                        strongself.students = students
                        strongself.tableView.reloadData()
                        strongself.hideIndicator()
                    }
                }, failure: { [weak self] error in
                    guard let strongself = self else { return }
                    updateUI {
                        strongself.hideIndicator()
                        strongself.showAlert(withError: error)
                    }
                })
            }
        } else {
            students = StudentsInformation.sharedInstance.students
            tableView.reloadData()
            hideIndicator()
        }
    }

}
