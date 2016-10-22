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
 
    @IBOutlet weak var excessivelyActive: RecordEntryView!
    @IBOutlet weak var abnormalRepMov: RecordEntryView!
    @IBOutlet weak var selfInjury: RecordEntryView!
    @IBOutlet weak var sluggish: RecordEntryView!
    @IBOutlet weak var scream: RecordEntryView!
    @IBOutlet weak var doneButton: UIBarButtonItem!


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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change the name labels
        excessivelyActive.setItemName(name: "Excessively Active")
        abnormalRepMov.setItemName(name: "Abnormal Repetitive Movements")
        selfInjury.setItemName(name: "Self-Injury")
        sluggish.setItemName(name: "Sluggish, Inactive")
        scream.setItemName(name: "Screams Inappropriately")

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
