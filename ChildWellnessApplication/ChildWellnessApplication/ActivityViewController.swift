//
//  ActivityViewController.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/20/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    //MARK: Properties
 
    //The existing activity object for the record, which is passed by the record form controller if one exists
    var existingActivity: ActivityObject?
    
    @IBOutlet weak var excessivelyActive: RecordEntryView!
    @IBOutlet weak var abnormalRepMov: RecordEntryView!
    @IBOutlet weak var selfInjury: RecordEntryView!
    @IBOutlet weak var sluggish: RecordEntryView!
    @IBOutlet weak var scream: RecordEntryView!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    //MARK: Helper Methods
    
    //Helper method to create an activity object from the form values
    func initActivityObject()-> ActivityObject{
        let activity = ActivityObject()
        activity.excessivelyActive = excessivelyActive.getSeverity()
        activity.excessivelyActiveDesc = excessivelyActive.getExplanation()
        activity.abnormalRepMov = abnormalRepMov.getSeverity()
        activity.abnormalRepMovDesc = abnormalRepMov.getExplanation()
        activity.selfInjury = selfInjury.getSeverity()
        activity.selfInjuryDesc = selfInjury.getExplanation()
        activity.sluggish = sluggish.getSeverity()
        activity.sluggishDesc = sluggish.getExplanation()
        activity.screams = scream.getSeverity()
        activity.screamsDesc = scream.getExplanation()
        return activity
    }
    
    //Helper for filling existing values into the form if the existingActivity object has been sent from the RecordFormViewController
    func fillExistingValues(){
        if (existingActivity != nil){
            excessivelyActive.setExistingValues(severity: (existingActivity?.excessivelyActive)!, text: (existingActivity?.excessivelyActiveDesc)!)
            abnormalRepMov.setExistingValues(severity: (existingActivity?.abnormalRepMov)!, text: (existingActivity?.abnormalRepMovDesc)!)
            selfInjury.setExistingValues(severity: (existingActivity?.selfInjury)!, text: (existingActivity?.selfInjuryDesc)!)
            sluggish.setExistingValues(severity: (existingActivity?.sluggish)!, text: (existingActivity?.sluggishDesc)!)
            scream.setExistingValues(severity: (existingActivity?.screams)!, text: (existingActivity?.screamsDesc)!)
        }
    }
    
    //MARK: Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change the name labels
        excessivelyActive.setItemName(name: "Excessively Active")
        abnormalRepMov.setItemName(name: "Abnormal Repetitive Movements")
        selfInjury.setItemName(name: "Self-Injury")
        sluggish.setItemName(name: "Sluggish, Inactive")
        scream.setItemName(name: "Screams Inappropriately")
        excessivelyActive.infoDescription = "Excessively active for long period of time,restless, unable to sit still"
        abnormalRepMov.infoDescription = "Stereotyped behavior, meaningless recurring body movements"
        selfInjury.infoDescription = "Deliberately engage in activity that lead to physical injury to self"
        sluggish.infoDescription = "Few movements, sits or stands in one position for a long period of time"
        scream.infoDescription = "Yells or screams at inappropriate times, over minor annoyance or no apparent provocation, or screams for an extended period of time"
        excessivelyActive.presenter = self
        abnormalRepMov.presenter = self
        selfInjury.presenter = self
        sluggish.presenter = self
        scream.presenter = self
        // Fill in the form with existing values if they are available
        fillExistingValues()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Set the record's activity data with the data currently in the form if the "Done" button is pressed
        if let barButton = sender as? UIBarButtonItem{
            if barButton === doneButton{
                if let recordForm = segue.destination as? RecordFormViewController{
                    recordForm.record.activity = initActivityObject()
                } 
            }
        }
        
    }

}
