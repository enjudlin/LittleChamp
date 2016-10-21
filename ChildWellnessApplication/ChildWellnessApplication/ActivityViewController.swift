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
    @IBOutlet weak var abnormalMovements: RecordEntryView!
    @IBOutlet weak var selfInjury: RecordEntryView!
    @IBOutlet weak var inactive: RecordEntryView!
    @IBOutlet weak var scream: RecordEntryView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Change the name labels on records
        excessivelyActive.setItemName(name: "Excessively Active")
        abnormalMovements.setItemName(name: "Abnormal Repetitive Movements")
        selfInjury.setItemName(name: "Self-Injury")
        inactive.setItemName(name: "Sluggish, Inactive")
        scream.setItemName(name: "Screams Inappropriately")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
