//
//  SocialViewController.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/22/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class SocialViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var argue: RecordEntryView!
    @IBOutlet weak var defiant: RecordEntryView!
    @IBOutlet weak var withdrawn: RecordEntryView!
    @IBOutlet weak var resistContact: RecordEntryView!
    @IBOutlet weak var harmOthers: RecordEntryView!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    
    //The existing social object for the record, which is passed by the record form controller if one exists
    var existingSocial: SocialObject?
    
    
    //MARK: Helper Methods
    
    //Helper method to create an emotion object from the form values
    func initSocialObject()-> SocialObject{
        let social = SocialObject()
        social.argue = argue.getSeverity()
        social.argueDesc = argue.getExplanation()
        social.defiant = defiant.getSeverity()
        social.defiantDesc = defiant.getExplanation()
        social.withdrawn = withdrawn.getSeverity()
        social.withdrawnDesc = withdrawn.getExplanation()
        social.resistContact = resistContact.getSeverity()
        social.resistContactDesc = resistContact.getExplanation()
        social.harmOthers = harmOthers.getSeverity()
        social.harmOthersDesc = harmOthers.getExplanation()
        return social
    }
    
    //Helper for filling existing values into the form if the existingActivity object has been sent from the RecordFormViewController
    func fillExistingValues(){
        if (existingSocial != nil){
            argue.setExistingValues(severity: (existingSocial?.argue)!, text: (existingSocial?.argueDesc)!)
            defiant.setExistingValues(severity: (existingSocial?.defiant)!, text: (existingSocial?.defiantDesc)!)
            withdrawn.setExistingValues(severity: (existingSocial?.withdrawn)!, text: (existingSocial?.withdrawnDesc)!)
            resistContact.setExistingValues(severity: (existingSocial?.resistContact)!, text: (existingSocial?.resistContactDesc)!)
            harmOthers.setExistingValues(severity: (existingSocial?.harmOthers)!, text: (existingSocial?.harmOthersDesc)!)
        }
    }
    
    //MARK: Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the name labels
        argue.setItemName(name: "Argue with Others")
        defiant.setItemName(name: "Defiant, Difficult to Control")
        withdrawn.setItemName(name: "Withdrawn, Refuse Contact with Others")
        resistContact.setItemName(name: "Resist Physical Contact")
        harmOthers.setItemName(name: "Physically Hurt Others")
        
        // Fill in the form with existing values if they are available
        fillExistingValues()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Set the record's emotion data with the data currently in the form if the "Done" button is pressed
        if let barButton = sender as? UIBarButtonItem{
            if barButton === doneButton{
                if let recordForm = segue.destination as? RecordFormViewController{
                    recordForm.record.social = initSocialObject()
                }
            }
        }
        
    }

}
