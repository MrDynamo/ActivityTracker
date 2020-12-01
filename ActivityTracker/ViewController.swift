//
//  ViewController.swift
//  ActivityTracker
//
//  Created by Morgan, Walker J on 11/29/20.
//

import UIKit

class ViewController: UIViewController {
    
    //var activityTable: UITableView!
    //var activityDataSource: ActivityController!
    //var activityDelegate: ActivityController!
    
    // Create title and table
    private let titleLabel: UILabel = UILabel()
    public let activityTable: UITableView = UITableView()
    
    // Create buttons
    private let newButton: UIButton = UIButton()
    private let editButton: UIButton = UIButton()
    private let deleteButton: UIButton = UIButton()
    private let settingsButton: UIButton = UIButton()
    
    // Button Details
    private var BUTTONOFFSET: CGFloat = 0.0
    private var BUTTONSIZE: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set background color to user chosen, else default light gray
        view.backgroundColor = SettingsController().mainBgColor
        
        // Set button details
        BUTTONOFFSET = view.frame.width/5
        BUTTONSIZE = view.frame.width/7
        
        // Activity Tracker Label
        titleLabel.frame = CGRect(x: 0, y: 55, width: view.frame.width, height: 25)
        titleLabel.text = "Activity Tracker"
        titleLabel.font = UIFont.systemFont(ofSize: 24.0)
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        
        // Activity table - populate from file
        //activityTable = UITableView()
        activityTable.frame = CGRect(x: 25, y: 100, width: view.frame.width - 50, height: view.frame.height - 250)
        activityTable.layer.borderColor = UIColor.black.cgColor
        activityTable.layer.borderWidth = 1
        activityTable.allowsSelection = true
        activityTable.isUserInteractionEnabled = true
        //activityTable.dataSource = activityDataSource
        //activityTable.delegate = activityDelegate
        //activityTable.register(UITableViewCell.self, forCellReuseIdentifier: "ActivityCell")
        view.addSubview(activityTable)
        
        // Button to add new activity
        newButton.frame = CGRect(x: BUTTONOFFSET * 1 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        newButton.setImage(UIImage(named: "NewButton"), for: UIControl.State.normal)
        newButton.setImage(UIImage(named: "NewButtonH"), for: UIControl.State.highlighted)
        newButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        newButton.isUserInteractionEnabled = true
        view.addSubview(newButton)
         
        // Button to edit activity
        editButton.frame = CGRect(x: BUTTONOFFSET * 2 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        editButton.setImage(UIImage(named: "EditButton"), for: UIControl.State.normal)
        editButton.setImage(UIImage(named: "EditButtonH"), for: UIControl.State.highlighted)
        editButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        editButton.isUserInteractionEnabled = true
        view.addSubview(editButton)
        
        // Button to delete activity
        deleteButton.frame = CGRect(x: BUTTONOFFSET * 3 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        deleteButton.setImage(UIImage(named: "DeleteButton"), for: UIControl.State.normal)
        deleteButton.setImage(UIImage(named: "DeleteButtonH"), for: UIControl.State.highlighted)
        deleteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        deleteButton.isUserInteractionEnabled = true
        view.addSubview(deleteButton)
        
        // Button to access settings menu
        settingsButton.frame = CGRect(x: BUTTONOFFSET * 4 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        settingsButton.setImage(UIImage(named: "SettingsButton"), for: UIControl.State.normal)
        settingsButton.setImage(UIImage(named: "SettingsButtonH"), for: UIControl.State.highlighted)
        settingsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        settingsButton.isUserInteractionEnabled = true
        view.addSubview(settingsButton)
        
        //ActivityController(tableView: activityTable).createDirectory()
        //ActivityController(tableView: activityTable).restoreFromFile()
        
        // Reload table
        activityTable.reloadData()
        
        // Reload file
        ActivityController().createDirectory()
        ActivityController().restoreFromFile()
            
    }
    
    // Method to handle tapping of buttons
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        // New Button
        if (recognizer.view == newButton) {
            //let avc: ActivityController = ActivityController(tableView: activityTable)
            let avc: ActivityController = ActivityController()
            avc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            present(avc, animated: true, completion: {() -> Void in
                print("Activity view controller presented...")
            })
        }
        
        // Edit Button
        if (recognizer.view == editButton) {
            
        }
        
        // Delete Button
        if (recognizer.view == deleteButton) {
            deleteButton.addTarget(self, action: #selector(ActivityController.deleteActivity), for: UIControl.Event.touchUpInside)
        }
        
        // Settings Button
        if (recognizer.view == settingsButton) {
            let svc: SettingsController = SettingsController()
            svc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            present(svc, animated: true, completion: {() -> Void in
                print("Settings view controller presented...")
            })
        }
        
    }


}

