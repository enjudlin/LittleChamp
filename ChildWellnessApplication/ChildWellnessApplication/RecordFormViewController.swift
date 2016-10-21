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
                //Save record to database
                record.create()
            }
        }
    }

}