//
//  SelectActionViewController.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/18/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class SelectActionViewController: UIViewController {
    
    //MARK: Properties
    var child: Child?
    var user: AppUser?
    
    @IBOutlet weak var viewInfoButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Custom styling for buttons
        viewInfoButton.layer.cornerRadius = 4
        
        //Make the top bar show the child's name
        navigationItem.title = child?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "viewInfo"{
            if let childProfileViewController = segue.destination as? ChildProfileViewController{
                childProfileViewController.child = child
                childProfileViewController.user = user
            }
        }
        else if segue.identifier == "newRecord"{
            if let navController = segue.destination as? UINavigationController{
                if let recordForm = navController.viewControllers.first as? RecordFormViewController{
                    //Set the record's child reference
                    recordForm.child = child?.appChild
                }
            }
        }
        else if let dc = segue.destination as? AnalysisDashboardController{
            dc.child = child
        }
    }
    
    //Landing point for returning to this view from a record
    @IBAction func unwindToActionList(sender: UIStoryboardSegue) {
        
    }


}
