//
//  RecordEntryView.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/20/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class RecordEntryView: UIView {
    @IBOutlet var recordEntry: UIView!

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var explanation: UITextField!
    @IBOutlet weak var severitySelect: UISegmentedControl!
    var infoDescription: String?
    var presenter: UIViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Add view file to bundle so that it can be accessed from the storyboard
        Bundle.main.loadNibNamed("RecordEntryView", owner: self, options: nil)
        self.addSubview(self.recordEntry)
    }
    
    //Setter for the item name
    func setItemName(name: String) {
        itemName.text = name
    }
    
    //Return the item name
    func getItemName()->String{
        return itemName.text!
    }
    
    //Return -1 if not selected and 0, 1, or 2 for mild, moderate, and severe respectively
    func getSeverity()->Int{
        return severitySelect.selectedSegmentIndex
    }
    
    //Return the explanation text entered by the user
    func getExplanation()->String{
        return explanation.text!
    }
    
    //Helper to set existing values
    func setExistingValues(severity: Int, text: String){
        severitySelect.selectedSegmentIndex = severity
        explanation.text = text
    }

    @IBAction func displayInfo(_ sender: AnyObject) {
            let myAlert = UIAlertController(title: itemName.text, message: infoDescription, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "ok", style:UIAlertActionStyle.default, handler:nil)
            myAlert.addAction(okAction)
            presenter?.present(myAlert, animated: true, completion:nil)
        }
}
