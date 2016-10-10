//
//  ChildFormViewController.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/4/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class ChildFormViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var childNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderFieldLabel: UILabel!
    @IBOutlet weak var genderSelectField: UISegmentedControl!
    @IBOutlet weak var birthDateFieldLabel: UILabel!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
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
                let name = nameTextField.text ?? ""
                let gender = genderSelectField.titleForSegment(at: genderSelectField.selectedSegmentIndex)?.lowercased()
                let birthDate = birthDatePicker.date
                // Set the child to be passed to ChildProfileTableViewController after the unwind segue.
                child = Child(name: name, gender: gender!, birthDate: birthDate)
            }
        }
        
    }
    


}
