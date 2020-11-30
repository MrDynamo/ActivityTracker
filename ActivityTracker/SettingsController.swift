//
//  SettingsController.swift
//  ActivityTracker
//
//  Created by Morgan, Walker J on 11/29/20.
//

import UIKit

class SettingsController: UIViewController {
    
    private let titleLabel: UILabel = UILabel()
    private let activityTable: UITableView = UITableView()
    
    private let backButton: UIButton = UIButton()
    private let saveButton: UIButton = UIButton()
    
    private var BUTTONOFFSET: CGFloat = 0.0
    private var BUTTONSIZE: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        
        BUTTONOFFSET = view.frame.width/3
        BUTTONSIZE = view.frame.width/7
        
        // New Activity Label
        titleLabel.frame = CGRect(x: 0, y: 55, width: view.frame.width, height: 20)
        titleLabel.text = "Settings"
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        
        // Button to go back to main screen
        backButton.frame = CGRect(x: view.frame.width/2 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        backButton.setImage(UIImage(named: "BackButton"), for: UIControl.State.normal)
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
        
    }
    
}
