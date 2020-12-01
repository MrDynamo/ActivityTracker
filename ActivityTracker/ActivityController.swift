//
//  NewActivityController.swift
//  ActivityTracker
//
//  Created by Morgan, Walker J on 11/29/20.
//

import UIKit

class ActivityController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // Define title
    private let titleLabel: UILabel = UILabel()
    
    // Define buttons
    private let backButton: UIButton = UIButton()
    private let saveButton: UIButton = UIButton()
    
    // Button details
    private var BUTTONOFFSET: CGFloat = 0.0
    private var BUTTONSIZE: CGFloat = 0.0
    
    // Define fields
    let descriptionLabel: UILabel = UILabel()
    let descriptionTextField: UITextField = UITextField()
    let startDateLabel: UILabel = UILabel()
    let startDatePicker: UIDatePicker = UIDatePicker()
    let endDateLabel: UILabel = UILabel()
    let endDatePicker: UIDatePicker = UIDatePicker()
    
    // Cell string
    let ACTIVITYCELL: String = "ActivityCell"
    
    // File paths
    let dirPath: String = "\(NSHomeDirectory())/tmp"
    let filePath: String = "\(NSHomeDirectory())/tmp/activity.txt"
    
    // Define table and activity list
    var activityTableView: UITableView = ViewController().activityTable
    var activityList = [Activity]()
    
    /*
    init(tableView: UITableView) {
        self.activityTableView = tableView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color to user chosen, else default light gray
        view.backgroundColor = SettingsController().activityBgColor
    
        // Set button details
        BUTTONOFFSET = view.frame.width/3
        BUTTONSIZE = view.frame.width/7
        
        // Table delegate and data source
        activityTableView.dataSource = self
        activityTableView.delegate = self
        activityTableView.register(UITableViewCell.self, forCellReuseIdentifier: ACTIVITYCELL)
        
        // New Activity Label
        titleLabel.frame = CGRect(x: 0, y: 55, width: view.frame.width, height: 25)
        titleLabel.text = "New/Edit Activity"
        titleLabel.font = UIFont.systemFont(ofSize: 24.0)
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        
        // Button to go back to main screen
        backButton.frame = CGRect(x: BUTTONOFFSET * 1 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        backButton.setImage(UIImage(named: "BackButton"), for: UIControl.State.normal)
        backButton.setImage(UIImage(named: "BackButtonH"), for: UIControl.State.highlighted)
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:))))
        backButton.isUserInteractionEnabled = true
        view.addSubview(backButton)
        
        // Button to save new activity
        saveButton.frame = CGRect(x: BUTTONOFFSET * 2 - BUTTONSIZE/2, y: view.frame.height - 100, width: BUTTONSIZE, height: BUTTONSIZE)
        saveButton.setImage(UIImage(named: "SaveButton"), for: UIControl.State.normal)
        saveButton.setImage(UIImage(named: "SaveButtonH"), for: UIControl.State.highlighted)
        saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActivityController.handleTap(_:))))
        saveButton.isUserInteractionEnabled = true
        view.addSubview(saveButton)
        
        // Description box label
        descriptionLabel.frame = CGRect(x: 25, y: 100, width: view.frame.width - 50, height: 25)
        descriptionLabel.text = "Activity Description"
        descriptionLabel.textAlignment = NSTextAlignment.center
        view.addSubview(descriptionLabel)
        
        // Description text field
        descriptionTextField.frame = CGRect(x: 25, y: 150, width: view.frame.width - 50, height: 150)
        descriptionTextField.textColor = UIColor.black
        descriptionTextField.font = UIFont.systemFont(ofSize: 24.0)
        descriptionTextField.backgroundColor = UIColor.white
        descriptionTextField.keyboardType = UIKeyboardType.default
        descriptionTextField.returnKeyType = UIReturnKeyType.done
        descriptionTextField.clearButtonMode = UITextField.ViewMode.always
        descriptionTextField.layer.borderColor = UIColor.black.cgColor
        descriptionTextField.borderStyle = UITextField.BorderStyle.line
        descriptionTextField.layer.borderWidth = 1
        descriptionTextField.delegate = self
        view.addSubview(descriptionTextField)
        
        // Start date/time label
        startDateLabel.frame = CGRect(x: 25, y: 350, width: view.frame.width - 50, height: 25)
        startDateLabel.text = "Starting Date/Time"
        startDateLabel.textAlignment = NSTextAlignment.center
        view.addSubview(startDateLabel)
        
        // Start date/time picker
        startDatePicker.frame = CGRect(x: 25, y: 400, width: view.frame.width - 50, height: 50)
        startDatePicker.backgroundColor = UIColor.white
        startDatePicker.layer.borderColor = UIColor.black.cgColor
        startDatePicker.layer.borderWidth = 1
        view.addSubview(startDatePicker)
        
        // End date/time label
        endDateLabel.frame = CGRect(x: 25, y: 475, width: view.frame.width - 50, height: 25)
        endDateLabel.text = "Ending Date/Time"
        endDateLabel.textAlignment = NSTextAlignment.center
        view.addSubview(endDateLabel)
        
        // End date/time picker
        endDatePicker.frame = CGRect(x: 25, y: 550, width: view.frame.width - 50, height: 50)
        endDatePicker.backgroundColor = UIColor.white
        endDatePicker.layer.borderColor = UIColor.black.cgColor
        endDatePicker.layer.borderWidth = 1
        view.addSubview(endDatePicker)
        
        createDirectory()
        restoreFromFile()
        
    }
    
    // Method to handle tapping of buttons
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {

        // Back Button
        if (recognizer.view == backButton) {
            restoreFromFile()
            activityTableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
        
        // Save Button
        if (recognizer.view == saveButton) {
            saveActivity()
            restoreFromFile()
            activityTableView.reloadData()
            self.dismiss(animated: true, completion: nil)
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
    
    public func createDirectory() {
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
    
    public func restoreFromFile() {
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
    
    public func deleteFile() {
        do {
            try FileManager.default.removeItem(atPath: filePath)
        }
        catch {
            print("Error deleting file: \(error)")
        }
    }
    
    @objc func clearActivities() {
        activityList.removeAll()
        
        deleteFile()
        
        activityTableView.reloadData()
    }
    
    @objc func saveActivity() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let startDate = dateFormatter.string(from: startDatePicker.date)
        let endDate = dateFormatter.string(from: endDatePicker.date)
        activityList.append(Activity(id: Int32(activityList.count + 1), desc: descriptionTextField.text, start: startDate, end: endDate))
        saveToFile()
        restoreFromFile()
        activityTableView.reloadData()
    }
    
    @objc func deleteActivity() {
        activityList.remove(at: 0)
        saveToFile()
        restoreFromFile()
        activityTableView.reloadData()
        // get index of currently selected
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ACTIVITYCELL) ?? UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: ACTIVITYCELL)
        //let cell = ActivityCell(style: .default, reuseIdentifier: ACTIVITYCELL)
        let activity: Activity
        activity = activityList[indexPath.row]
        cell.textLabel?.text = activity.desc
        cell.backgroundColor = UIColor.magenta
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let activity: Activity
        //activity = activityList[indexPath.row]
    }
    
}

class Activity: NSObject, NSCoding {
    let AID: String = "Activity ID"
    let ADESC: String = "Activity Description"
    let ASTART: String = "Activity Start"
    let AEND: String = "Activity End"
    
    let id: Int32
    let desc: String?
    let start: String?
    let end: String?
    
    init(id: Int32, desc: String?, start: String?, end: String?){
        self.id = id
        self.desc = desc
        self.start = start
        self.end = end
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeInt32(forKey: AID)
        desc = aDecoder.decodeObject(forKey: ADESC) as? String
        start = aDecoder.decodeObject(forKey: ASTART) as? String
        end = aDecoder.decodeObject(forKey: AEND) as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: AID)
        aCoder.encode(desc, forKey: ADESC)
        aCoder.encode(start, forKey: ASTART)
        aCoder.encode(end, forKey: AEND)
    }
}

/*
class ActivityCell: UITableViewCell {
    var label: UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.textColor = .black
        label.backgroundColor = .yellow
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
 */
