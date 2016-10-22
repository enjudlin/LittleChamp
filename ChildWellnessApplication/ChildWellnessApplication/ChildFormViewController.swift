//
//  ChildFormViewController.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/4/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit
import RealmSwift

class ChildFormViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderFieldLabel: UILabel!
    @IBOutlet weak var genderSelectField: UISegmentedControl!
    @IBOutlet weak var birthDateFieldLabel: UILabel!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pageTitle: UINavigationItem!
    
    //Pass the parent from the table view
    var user: AppUser?
    var editMode = false
    
    
    /*
     This value is either passed by `ChildProfileTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new child.
     */
    var child: Child?
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid name.
        checkValidName()
        
        //if edit mode, display values of child
        if editMode {
            saveButton.isEnabled = true
            pageTitle.title = "Edit Child"
            nameTextField.text = child?.name
            if child?.gender == "male"{
                genderSelectField.selectedSegmentIndex = 0;
            }
            else{
                genderSelectField.selectedSegmentIndex = 1;
            }
            birthDatePicker.date = (child?.birthDate)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: UITextFieldDelegate
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func checkValidName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidName()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    
    
    //MARK: Navigation
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let barButton = sender as? UIBarButtonItem{
            if saveButton === barButton {
                if  editMode != true{
                    let name = nameTextField.text ?? ""
                    let gender = genderSelectField.titleForSegment(at: genderSelectField.selectedSegmentIndex)?.lowercased()
                    let birthDate = birthDatePicker.date
                    // Set the child to be passed to ChildProfileTableViewController after the unwind segue.
                    child = Child(name: name, gender: gender!, birthDate: birthDate, parent: self.user!)
                    //Save child in Realm database
                    child!.createChild()
                }
                else{
                    child!.updateChild(child: Child(name: nameTextField.text!, gender: (genderSelectField.titleForSegment(at: genderSelectField.selectedSegmentIndex)?.lowercased())!, birthDate: birthDatePicker.date, parent: self.user!)!, name: (child?.name)!)
                }
            }
        }
        if let childProfileTableViewController = segue.destination as? ChildProfileTableViewController{
            if editMode{
                childProfileTableViewController.senderWasEditing = true
            }
            else{
                childProfileTableViewController.senderWasEditing = false
            }
        }
    }
    


}
