//
//  ViewController.swift
//  ActivityTracker
//
//  Created by Morgan, Walker J on 11/29/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.lightGray
        
        // Activity table - populate from file
        let activityTable: UITableView = UITableView(frame: CGRect(x: 25, y: 60, width: view.frame.width - 50, height: view.frame.height - 200))
        activityTable.allowsSelection = true
        activityTable.isUserInteractionEnabled = true
        view.addSubview(activityTable)
        
        // Button to add new activity
        let newButton: UIButton = UIButton()
        newButton.isUserInteractionEnabled = true
        view.addSubview(newButton)
         
        // Button to edit activity
        let editButton: UIButton = UIButton()
        editButton.isUserInteractionEnabled = true
        view.addSubview(editButton)
        
        // Button to delete activity
        let deleteButton: UIButton = UIButton()
        deleteButton.isUserInteractionEnabled = true
        view.addSubview(deleteButton)
        
        // Button to access settings menu
        let settingsButton: UIButton = UIButton()
        settingsButton.isUserInteractionEnabled = true
        view.addSubview(settingsButton)
        
    }


}

