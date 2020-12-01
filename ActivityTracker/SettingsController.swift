//
//  SettingsController.swift
//  ActivityTracker
//
//  Created by Morgan, Walker J on 11/29/20.
//

import UIKit

class SettingsController: UIViewController {
    
    // Tables and title
    private let titleLabel: UILabel = UILabel()
    private let activityTable: UITableView = UITableView()
    
    // Labels
    private let mainColorLabel: UILabel = UILabel()
    private let activityColorLabel: UILabel = UILabel()
    private let buttonColorLabel: UILabel = UILabel()
    private let deleteFileLabel: UILabel = UILabel()
    
    // Color wells
    private let mainColorWell: UIColorWell = UIColorWell()
    private let activityColorWell: UIColorWell = UIColorWell()
    private let buttonColorWell: UIColorWell = UIColorWell()
    
    // Buttons
    private let backButton: UIButton = UIButton()
    private let saveButton: UIButton = UIButton()
    private let deleteFileButton: UIButton = UIButton()
    
    // Button details
    private var BUTTONOFFSET: CGFloat = 0.0
    private var BUTTONSIZE: CGFloat = 0.0
    
    // Colors
    public var mainBgColor: UIColor = UIColor.lightGray
    public var activityBgColor: UIColor = UIColor.lightGray
    public var buttonColor: UIColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        
        BUTTONOFFSET = view.frame.width/3
        BUTTONSIZE = view.frame.width/7
        
        // New Activity Label
        titleLabel.frame = CGRect(x: 0, y: 55, width: view.frame.width, height: 25)
        titleLabel.text = "Settings"
        titleLabel.font = UIFont.systemFont(ofSize: 24.0)
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        
        // Main bg color label
        mainColorLabel.frame = CGRect(x: 25, y: 100, width: view.frame.width - 125, height: 25)
        mainColorLabel.text = "Select a main background color"
        mainColorLabel.textAlignment = NSTextAlignment.center
        mainColorLabel.numberOfLines = 1
        mainColorLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(mainColorLabel)
        
        // Main bg color well
        mainColorWell.frame = CGRect(x: view.frame.width - 75, y: 100, width: 25, height: 25)
        mainColorWell.center = view.center
        mainColorWell.title = "Select color"
        mainColorWell.supportsAlpha = false
        mainColorWell.tag = 1
        mainColorWell.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
        view.addSubview(mainColorWell)
        
        // Activity bg color label
        activityColorLabel.frame = CGRect(x: 25, y: 200, width: view.frame.width - 125, height: 25)
        activityColorLabel.text = "Select an activity background color"
        activityColorLabel.textAlignment = NSTextAlignment.center
        activityColorLabel.numberOfLines = 1
        activityColorLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(activityColorLabel)
        
        // Activity bg color well
        activityColorWell.frame = CGRect(x: view.frame.width - 75, y: 200, width: 25, height: 25)
        activityColorWell.center = view.center
        activityColorWell.title = "Select color"
        activityColorWell.supportsAlpha = false
        activityColorWell.tag = 2
        activityColorWell.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
        view.addSubview(activityColorWell)
        
        // Button color label
        buttonColorLabel.frame = CGRect(x: 25, y: 300, width: view.frame.width - 125, height: 25)
        buttonColorLabel.text = "Select an activity background color"
        buttonColorLabel.textAlignment = NSTextAlignment.center
        buttonColorLabel.numberOfLines = 1
        buttonColorLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(buttonColorLabel)
        
        // Button color well
        buttonColorWell.frame = CGRect(x: view.frame.width - 75, y: 300, width: 25, height: 25)
        buttonColorWell.center = view.center
        buttonColorWell.title = "Select color"
        buttonColorWell.supportsAlpha = false
        buttonColorWell.tag = 3
        buttonColorWell.addTarget(self, action: #selector(colorWellChanged(_:)), for: .valueChanged)
        view.addSubview(buttonColorWell)
        
        // Delete file label
        deleteFileLabel.frame = CGRect(x: 25, y: 500 + 25/2, width: view.frame.width - 150, height: 25)
        deleteFileLabel.text = "Delete activity file"
        view.addSubview(deleteFileLabel)
        
        // Delete file button
        deleteFileButton.frame = CGRect(x: view.frame.width - 75, y: 500, width: BUTTONSIZE, height: BUTTONSIZE)
        deleteFileButton.setImage(UIImage(named: "DeleteButton"), for: UIControl.State.normal)
        deleteFileButton.setImage(UIImage(named: "DeleteButtonH"), for: UIControl.State.highlighted)
        deleteFileButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        deleteFileButton.isUserInteractionEnabled = true
        view.addSubview(deleteFileButton)
        
        // Button to go back to main screen
        backButton.frame = CGRect(x: view.frame.width/2 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        backButton.setImage(UIImage(named: "BackButton"), for: UIControl.State.normal)
        backButton.setImage(UIImage(named: "BackButtonH"), for: UIControl.State.highlighted)
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        backButton.isUserInteractionEnabled = true
        view.addSubview(backButton)
        
    }
    
    // Method to handle tapping of buttons
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        // Back Button
        if (recognizer.view == backButton) {
            self.dismiss(animated: true, completion: nil)
        }
        
        // Delete file button
        if (recognizer.view == deleteFileButton) {
            ActivityController().deleteFile()
        }
        
        /*
        if (recognizer.view == mainColorWell) {
            mainBgColor = mainColorWell.selectedColor ?? .lightGray
            viewDidLoad()
        }
        
        if (recognizer.view == activityColorWell) {
            activityBgColor = mainColorWell.selectedColor ?? .lightGray
            viewDidLoad()
        }
        
        if (recognizer.view == buttonColorWell) {
            buttonColor = mainColorWell.selectedColor ?? .black
            viewDidLoad()
        }
         */
        
    }
    
    @objc func colorWellChanged(_ sender: UIColorWell) {
        switch sender.tag {
            case 1:
                mainBgColor = mainColorWell.selectedColor ?? .lightGray
            case 2:
                activityBgColor = activityColorWell.selectedColor ?? .lightGray
            case 3:
                buttonColor = buttonColorWell.selectedColor ?? .black
            default: break
        }
        
    }
    
}
