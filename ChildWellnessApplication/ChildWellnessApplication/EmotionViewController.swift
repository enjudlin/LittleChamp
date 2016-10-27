//
//  EmotionViewController.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/22/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class EmotionViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var tantrum: RecordEntryView!
    @IBOutlet weak var depressed: RecordEntryView!
    @IBOutlet weak var emResponse: RecordEntryView!
    @IBOutlet weak var crying: RecordEntryView!
    @IBOutlet weak var moodChanges: RecordEntryView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    //The existing emotion object for the record, which is passed by the record form controller if one exists
    var existingEmotion: EmotionObject?
    
    
    //MARK: Helper Methods
    
    //Helper method to create an emotion object from the form values
    func initEmotionObject()-> EmotionObject{
        let emotion = EmotionObject()
        emotion.tantrum = tantrum.getSeverity()
        emotion.depressed = depressed.getSeverity()
        emotion.emResponse = emResponse.getSeverity()
        emotion.crying = crying.getSeverity()
        emotion.moodChanges = moodChanges.getSeverity()
        emotion.tantrumDesc = tantrum.getExplanation()
        emotion.depressedDesc = depressed.getExplanation()
        emotion.emResponseDesc = emResponse.getExplanation()
        emotion.cryingDesc = crying.getExplanation()
        emotion.moodChangesDesc = moodChanges.getExplanation()
       return emotion
    }
    
    //Helper for filling existing values into the form if the existingActivity object has been sent from the RecordFormViewController
    func fillExistingValues(){
        if (existingEmotion != nil){
            tantrum.setExistingValues(severity: (existingEmotion?.tantrum)!, text: (existingEmotion?.tantrumDesc)!)
            depressed.setExistingValues(severity: (existingEmotion?.depressed)!, text: (existingEmotion?.depressedDesc)!)
            emResponse.setExistingValues(severity: (existingEmotion?.emResponse)!, text: (existingEmotion?.emResponseDesc)!)
            crying.setExistingValues(severity: (existingEmotion?.crying)!, text: (existingEmotion?.cryingDesc)!)
            moodChanges.setExistingValues(severity: (existingEmotion?.moodChanges)!, text: (existingEmotion?.moodChangesDesc)!)
        }
    }
    
    //MARK: Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the name labels
        tantrum.setItemName(name: "Temper Tantrums/ Outbursts")
        depressed.setItemName(name: "Depressed Mood")
        emResponse.setItemName(name: "Lacks Emotional Responsiveness")
        crying.setItemName(name: "Excessive Crying Over Minor Irritant")
        moodChanges.setItemName(name: "Mood Changes Quickly")
        tantrum.infoDescription = "Emotional outburst, stubborness, defiance, anger, resistance to attempts to pacify"
        depressed.infoDescription = "Sad, anxious, irritable, restless"
        emResponse.infoDescription = "Failure to express verbal or non verbal emotion in response to emotional events"
        crying.infoDescription = "Crying about small things that normally wouldn't cause an emotional response"
        moodChanges.infoDescription = "Mood swings from being happy to sad frequently"
        tantrum.presenter = self
        depressed.presenter = self
        emResponse.presenter = self
        crying.presenter = self
        moodChanges.presenter = self
        
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
                    recordForm.record.emotion = initEmotionObject()
                }
            }
        }
        
    }

}
