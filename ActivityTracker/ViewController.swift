//
//  ViewController.swift
//  ActivityTracker
//
//  Created by Morgan, Walker J on 11/29/20.
//

import UIKit

class ViewController: UIViewController {
    
    private let titleLabel: UILabel = UILabel()
    private let activityTable: UITableView = UITableView()
    
    private let newButton: UIButton = UIButton()
    private let editButton: UIButton = UIButton()
    private let deleteButton: UIButton = UIButton()
    private let settingsButton: UIButton = UIButton()
    
    private var BUTTONOFFSET: CGFloat = 0.0
    private var BUTTONSIZE: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.lightGray
        
        BUTTONOFFSET = view.frame.width/5
        BUTTONSIZE = view.frame.width/7
        
        // Activity Tracker Label
        titleLabel.frame = CGRect(x: 0, y: 55, width: view.frame.width, height: 20)
        titleLabel.text = "Activity Tracker"
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        
        // Activity table - populate from file
        activityTable.frame = CGRect(x: 25, y: 100, width: view.frame.width - 50, height: view.frame.height - 250)
        activityTable.allowsSelection = true
        activityTable.isUserInteractionEnabled = true
        view.addSubview(activityTable)
        
        // Button to add new activity
        newButton.frame = CGRect(x: BUTTONOFFSET * 1 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        newButton.setImage(UIImage(named: "NewButton"), for: UIControl.State.normal)
        newButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        newButton.isUserInteractionEnabled = true
        view.addSubview(newButton)
         
        // Button to edit activity
        editButton.frame = CGRect(x: BUTTONOFFSET * 2 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        editButton.setImage(UIImage(named: "EditButton"), for: UIControl.State.normal)
        editButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        editButton.isUserInteractionEnabled = true
        view.addSubview(editButton)
        
        // Button to delete activity
        deleteButton.frame = CGRect(x: BUTTONOFFSET * 3 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        deleteButton.setImage(UIImage(named: "DeleteButton"), for: UIControl.State.normal)
        deleteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        deleteButton.isUserInteractionEnabled = true
        view.addSubview(deleteButton)
        
        // Button to access settings menu
        settingsButton.frame = CGRect(x: BUTTONOFFSET * 4 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        settingsButton.setImage(UIImage(named: "SettingsButton"), for: UIControl.State.normal)
        settingsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        settingsButton.isUserInteractionEnabled = true
        view.addSubview(settingsButton)
            
        }
    
    // Method to handle tapping of buttons
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        // New Button
        if (recognizer.view == newButton) {
            let nvc: NewActivityController = NewActivityController()
            nvc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            present(nvc, animated: true, completion: {() -> Void in
                print("New activity view controller presented...")
            })
        }
        
        // Edit Button
        if (recognizer.view == editButton) {
            
        }
        
        // Delete Button
        if (recognizer.view == deleteButton) {
            
            
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

