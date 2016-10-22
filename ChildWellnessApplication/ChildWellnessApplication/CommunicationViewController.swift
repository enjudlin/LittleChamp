//
//  CommunicationViewController.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/22/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class CommunicationViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var unresponsive: RecordEntryView!
    @IBOutlet weak var excessiveTalk: RecordEntryView!
    @IBOutlet weak var noCommunication: RecordEntryView!
    @IBOutlet weak var talkToSelf: RecordEntryView!
    @IBOutlet weak var difficultyExpressing: RecordEntryView!
    @IBOutlet weak var doneButton: UIBarButtonItem!


    //The existing social object for the record, which is passed by the record form controller if one exists
    var existingCommunication: CommunicationObject?
    
    
    //MARK: Helper Methods
    
    //Helper method to create an emotion object from the form values
    func initCommunicationObject()-> CommunicationObject{
        let communication = CommunicationObject()
        communication.unresponsive = unresponsive.getSeverity()
        communication.unresponsiveDesc = unresponsive.getExplanation()
        communication.excessiveTalk = excessiveTalk.getSeverity()
        communication.excessiveTalkDesc = excessiveTalk.getExplanation()
        communication.noCommunication = noCommunication.getSeverity()
        communication.noCommunicationDesc = noCommunication.getExplanation()
        communication.talkToSelf = talkToSelf.getSeverity()
        communication.talkToSelfDesc = talkToSelf.getExplanation()
        communication.difficultyExpressing = difficultyExpressing.getSeverity()
        communication.difficultyExpressingDesc = difficultyExpressing.getExplanation()
        return communication
    }
    
    //Helper for filling existing values into the form if the existingActivity object has been sent from the RecordFormViewController
    func fillExistingValues(){
        if (existingCommunication != nil){
            unresponsive.setExistingValues(severity: (existingCommunication?.unresponsive)!, text: (existingCommunication?.unresponsiveDesc)!)
            excessiveTalk.setExistingValues(severity: (existingCommunication?.excessiveTalk)!, text: (existingCommunication?.excessiveTalkDesc)!)
            noCommunication.setExistingValues(severity: (existingCommunication?.noCommunication)!, text: (existingCommunication?.noCommunicationDesc)!)
            talkToSelf.setExistingValues(severity: (existingCommunication?.talkToSelf)!, text: (existingCommunication?.talkToSelfDesc)!)
            difficultyExpressing.setExistingValues(severity: (existingCommunication?.difficultyExpressing)!, text: (existingCommunication?.difficultyExpressingDesc)!)
        }
    }
    
    //MARK: Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the name labels
        unresponsive.setItemName(name: "Unresponsive When Spoken To ")
        excessiveTalk.setItemName(name: "Talks Excessively")
        noCommunication.setItemName(name: "Does Not Try to Communicate")
        talkToSelf.setItemName(name: "Talks to Self Loudly")
        difficultyExpressing.setItemName(name: "Difficulty Expressing Self")
        
        // Fill in the form with existing values if they are available
        fillExistingValues()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    /* Make sure to set the RecordFormViewController to pass the object back if data is already present to be edited*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Set the record's emotion data with the data currently in the form if the "Done" button is pressed
        if let barButton = sender as? UIBarButtonItem{
            if barButton === doneButton{
                if let recordForm = segue.destination as? RecordFormViewController{
                    recordForm.record.communication = initCommunicationObject()
                }
            }
        }
        
    }

}
