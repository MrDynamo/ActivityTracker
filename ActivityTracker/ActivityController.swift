//
//  NewActivityController.swift
//  ActivityTracker
//
//  Created by Morgan, Walker J on 11/29/20.
//

import UIKit

class ActivityController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    private let titleLabel: UILabel = UILabel()
    //private let activityTable: UITableView = UITableView()
    
    private let backButton: UIButton = UIButton()
    private let saveButton: UIButton = UIButton()
    
    private var BUTTONOFFSET: CGFloat = 0.0
    private var BUTTONSIZE: CGFloat = 0.0
    
    let descriptionTextField: UITextField = UITextField()
    let dateTextField: UITextField = UITextField()
    let startingTimeTextField: UITextField = UITextField()
    let endingTimeTextField: UITextField = UITextField()
    
    let ACTIVITYCELL: String = "ActivityCell"
    
    let dirPath: String = "\(NSHomeDirectory())/tmp"
    let filePath: String = "\(NSHomeDirectory())/tmp/activity.txt"
    
    var activityTableView: UITableView = ViewController().activityTable
    var activityList = [Activity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        
        BUTTONOFFSET = view.frame.width/3
        BUTTONSIZE = view.frame.width/7
        
        // New Activity Label
        titleLabel.frame = CGRect(x: 0, y: 55, width: view.frame.width, height: 20)
        titleLabel.text = "New/Edit Activity"
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        
        // Button to go back to main screen
        backButton.frame = CGRect(x: BUTTONOFFSET * 1 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        backButton.setImage(UIImage(named: "BackButton"), for: UIControl.State.normal)
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        backButton.isUserInteractionEnabled = true
        view.addSubview(backButton)
        
        // Button to save new activity
        saveButton.frame = CGRect(x: BUTTONOFFSET * 2 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        saveButton.setImage(UIImage(named: "SaveButton"), for: UIControl.State.normal)
        saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        saveButton.isUserInteractionEnabled = true
        view.addSubview(saveButton)
        
        descriptionTextField.frame = CGRect(x: view.center.x-135, y: 50, width: 270, height: 50)
        descriptionTextField.textColor = UIColor.black
        descriptionTextField.font = UIFont.systemFont(ofSize: 24.0)
        descriptionTextField.placeholder = "<Enter an activity description>"
        descriptionTextField.backgroundColor = UIColor.white
        descriptionTextField.keyboardType = UIKeyboardType.default
        descriptionTextField.returnKeyType = UIReturnKeyType.done
        descriptionTextField.clearButtonMode = UITextField.ViewMode.always
        descriptionTextField.layer.borderColor = UIColor.black.cgColor
        descriptionTextField.borderStyle = UITextField.BorderStyle.line
        descriptionTextField.layer.borderWidth = 1
        descriptionTextField.delegate = self
        view.addSubview(descriptionTextField)
        
        dateTextField.frame = CGRect(x: view.center.x-135, y: 50, width: 270, height: 50)
        dateTextField.textColor = UIColor.black
        dateTextField.font = UIFont.systemFont(ofSize: 24.0)
        dateTextField.placeholder = "<Enter date of activity>"
        dateTextField.backgroundColor = UIColor.white
        dateTextField.keyboardType = UIKeyboardType.default
        dateTextField.returnKeyType = UIReturnKeyType.done
        dateTextField.clearButtonMode = UITextField.ViewMode.always
        dateTextField.layer.borderColor = UIColor.black.cgColor
        dateTextField.borderStyle = UITextField.BorderStyle.line
        dateTextField.layer.borderWidth = 1
        dateTextField.delegate = self
        view.addSubview(dateTextField)
        
        startingTimeTextField.frame = CGRect(x: view.center.x-135, y: 50, width: 270, height: 50)
        startingTimeTextField.textColor = UIColor.black
        startingTimeTextField.font = UIFont.systemFont(ofSize: 24.0)
        startingTimeTextField.placeholder = "<enter name>"
        startingTimeTextField.backgroundColor = UIColor.white
        startingTimeTextField.keyboardType = UIKeyboardType.default
        startingTimeTextField.returnKeyType = UIReturnKeyType.done
        startingTimeTextField.clearButtonMode = UITextField.ViewMode.always
        startingTimeTextField.layer.borderColor = UIColor.black.cgColor
        startingTimeTextField.borderStyle = UITextField.BorderStyle.line
        startingTimeTextField.layer.borderWidth = 1
        startingTimeTextField.delegate = self
        view.addSubview(startingTimeTextField)
        
        endingTimeTextField.frame = CGRect(x: view.center.x-135, y: 50, width: 270, height: 50)
        endingTimeTextField.textColor = UIColor.black
        endingTimeTextField.font = UIFont.systemFont(ofSize: 24.0)
        endingTimeTextField.placeholder = "<enter name>"
        endingTimeTextField.backgroundColor = UIColor.white
        endingTimeTextField.keyboardType = UIKeyboardType.default
        endingTimeTextField.returnKeyType = UIReturnKeyType.done
        endingTimeTextField.clearButtonMode = UITextField.ViewMode.always
        endingTimeTextField.layer.borderColor = UIColor.black.cgColor
        endingTimeTextField.borderStyle = UITextField.BorderStyle.line
        endingTimeTextField.layer.borderWidth = 1
        endingTimeTextField.delegate = self
        view.addSubview(endingTimeTextField)
        
    }
    
    // Method to handle tapping of buttons
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {

        // Back Button
        if (recognizer.view == backButton) {
            self.dismiss(animated: true, completion: nil)
        }
        
        // Save Button
        if (recognizer.view == saveButton) {
            saveButton.addTarget(self, action: #selector(ActivityController.saveActivity), for: UIControl.Event.touchUpInside)
        }
        
    }
    
    private func displayDirectory() {
        print("Absolute path for Home Directory: \(NSHomeDirectory())")
        if let dirEnumerator = FileManager.default.enumerator(atPath: NSHomeDirectory()) {
            while let currentPath = dirEnumerator.nextObject() as? String {
                print(currentPath)
            }
        }
    }
    
    private func createDirectory() {
        print("Before directory is created...")
        displayDirectory()
        var isDir: ObjCBool = true
        if FileManager.default.fileExists(atPath: dirPath, isDirectory: &isDir) {
            if isDir.boolValue {
                print("\(dirPath) exists and is a directory")
            }
            else {
                print("\(dirPath) exists and is not a directory")
            }
        }
        else {
            print("\(dirPath) does not exist")
            do {
                try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                print("Error creating directory \(dirPath): \(error)")
            }
        }
        print("After directory is created...")
        displayDirectory()
    }
    
    private func saveToFile() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: activityList, requiringSecureCoding: false)
            if FileManager.default.createFile(atPath: filePath,
                                      contents: data,
                                      attributes: nil) {
                print("File \(filePath) successfully created")
            }
            else {
                print("File \(filePath) could not be created")
            }
        }
        catch {
            print("Error archiving data: \(error)")
        }
    }
    
    private func restoreFromFile() {
        do {
            if let data = FileManager.default.contents(atPath: filePath) {
                print("Retrieving data from file \(filePath)")
                activityList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Activity] ?? [Activity]()
            }
            else {
                print("No data available in file \(filePath)")
                activityList = [Activity]()
            }
            activityTableView.reloadData()
        }
        catch {
            print("Error unarchiving data: \(error)")
        }
    }
    
    private func deleteFile() {
        do {
            try FileManager.default.removeItem(atPath: filePath)
        }
        catch {
            print("Error deleting file: \(error)")
        }
    }
    
    @objc func saveActivity() {
        
    }
    
    @objc func deleteActivity() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ACTIVITYCELL) ?? UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: ACTIVITYCELL)
        let activity: Activity
        activity = activityList[indexPath.row]
        cell.textLabel?.text = activity.desc
        cell.backgroundColor = UIColor.magenta
        return cell
    }
    
}

class Activity: NSObject, NSCoding {
    let ADESC: String = "Person ID"
    let ADATE: String = "Person Name"
    let ASTART: String = "Person Age"
    let AEND: String = "Person Age"
    
    let desc: String?
    let date: String?
    let start: String?
    let end: String?
    
    //var age: Int32
    
    init(desc: String?, date: String?, start: String?, end: String?){
        self.desc = desc
        self.date = date
        self.start = start
        self.end = end
    }
    
    required init(coder aDecoder: NSCoder) {
        desc = aDecoder.decodeObject(forKey: ADESC) as? String
        date = aDecoder.decodeObject(forKey: ADATE) as? String
        start = aDecoder.decodeObject(forKey: ASTART) as? String
        end = aDecoder.decodeObject(forKey: AEND) as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(desc, forKey: ADESC)
        aCoder.encode(date, forKey: ADATE)
        aCoder.encode(start, forKey: ASTART)
        aCoder.encode(end, forKey: AEND)
    }
}
