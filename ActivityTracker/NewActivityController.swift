//
//  NewActivityController.swift
//  ActivityTracker
//
//  Created by Morgan, Walker J on 11/29/20.
//

import UIKit

class NewActivityController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // New Activity Label
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 45, width: view.frame.width, height: 20))
        titleLabel.text = "New/Edit Activity"
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        
        // Button to go back to main screen
        let backButton: UIButton = UIButton()
        backButton.isUserInteractionEnabled = true
        view.addSubview(backButton)
        
        // Button to save new activity
        let saveButton: UIButton = UIButton()
        saveButton.isUserInteractionEnabled = true
        view.addSubview(saveButton)
        
    }
    
}
