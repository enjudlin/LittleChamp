//
//  ChildProfileTableViewController.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/3/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit
import RealmSwift

class ChildProfileTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var user: AppUser?
    var children = [Child]()
    var senderWasEditing = false;

    override func viewDidLoad() {
        super.viewDidLoad()
        children.append(contentsOf: self.user!.children())
        
        //Load sample data
        //loadSampleChildren()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func loadSampleChildren(){
        let child1 = Child(name: "Jane", gender: "female", birthDate: Date(), parent: AppUser())!
        let child2 = Child(name: "Jon", gender: "male", birthDate: Date(), parent: AppUser())!
     
        children += [child1, child2]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ChildProfileTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ChildProfileTableViewCell

        //Fetch the appropriate child for the data source layout
        
        let child = children[indexPath.row]
        
        //Set cell field values
        cell.nameLabel.text = child.name

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChild" {
            
            //Because the menu is embedded in a navigation controller, the menu controller must be accessed through the segue
            if let navController = segue.destination as? UINavigationController {
                if let selectActionController = navController.viewControllers.first as? SelectActionViewController{
                    // Get the cell that generated this segue.
                    if let selectedChildCell = sender as? ChildProfileTableViewCell {
                
                        let indexPath = tableView.indexPath(for: selectedChildCell)!
                        let selectedChild = children[indexPath.row]
                        selectActionController.child = selectedChild
                        selectActionController.user = user
                
                    }
                }
            }

        }
        else if segue.identifier == "AddChild"{
            let navController = segue.destination as? UINavigationController
            let form = navController?.viewControllers.first as? ChildFormViewController
            form?.user = self.user
        }
        
    }
 

    
    
    @IBAction func unwindToChildList(sender: UIStoryboardSegue) {
        
        
        if let sourceViewController = sender.source as? ChildFormViewController, let child = sourceViewController.child {
            
            
            // Add a new child if new child was added.
            if senderWasEditing != true{
                let newIndexPath = IndexPath(row: children.count, section: 0)
                children.append(child)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            //update child list with edited child
            else{
                children = (user?.children())!
                self.tableView.reloadData()
            }

        }
        
 
    }
    
    
    
    @IBAction func loginToChildList(sender: UIStoryboardSegue) {
        
    }
    

    
}
