//
//  SettingsController.swift
//  ActivityTracker
//
//  Created by Morgan, Walker J on 11/29/20.
//

import UIKit

class SettingsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Settings Label
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 45, width: view.frame.width, height: 20))
        titleLabel.text = "Settings"
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        
        // Button to go back to main screen
        let backButton: UIButton = UIButton()
        backButton.isUserInteractionEnabled = true
        view.addSubview(backButton)
        
    }
    
}
