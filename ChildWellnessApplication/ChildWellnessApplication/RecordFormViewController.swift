//
//  RecordFormViewController.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/20/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit
import RealmSwift

class RecordFormViewController: UIViewController {
    
    //MARK: Properties
    var child: AppChild?
    var record = RecordObject()

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Only save the record if the save button was clicked
        if let barButton = sender as? UIBarButtonItem{
            if saveButton === barButton {
                //Set record's child
                record.child = self.child
                
                //Save record to database
                record.create()
            }
        }
        else{
            //Pass the existing cooresponding object to the view controller if one already exists.
            if let destination = segue.destination as? ActivityViewController{
                if (self.record.activity != nil){
                    destination.existingActivity = self.record.activity
                }
            }
            else if let destination = segue.destination as? EmotionViewController{
                if (self.record.emotion != nil){
                    destination.existingEmotion = self.record.emotion
                }
            }
            else if let destination = segue.destination as? SocialViewController{
                if (self.record.social != nil){
                    destination.existingSocial = self.record.social                }
            }
            else if let destination = segue.destination as? CommunicationViewController{
                if (self.record.communication != nil){
                    destination.existingCommunication = self.record.communication               }
            }
            
        }
    }
    
    //Landing point for returning to this view from a subrecord form (activity, communication, etc)
    @IBAction func unwindToRecordForm(sender: UIStoryboardSegue) {
        
    }

}
