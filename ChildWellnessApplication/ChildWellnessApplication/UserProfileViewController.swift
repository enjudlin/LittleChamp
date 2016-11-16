//
//  UserProfileViewController.swift
//  ChildWellnessApplication
//
//  Created by Chen Rong on 11/15/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit
import RealmSwift

class UserProfileViewController: UIViewController {

    @IBOutlet weak var changePwdButton: UIButton!
    @IBOutlet weak var editUserProfileButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var user: AppUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // log out
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        let realm = try! Realm()
        let loggedInUser = realm.objects(LoggedInUser.self)
        if loggedInUser.isEmpty {
            // do nothing
        } else {
            // clear remained user data
            let temp = loggedInUser.first
            try! realm.write {
                realm.delete(temp!)
            }
        }
        self.performSegue(withIdentifier: "logout", sender: self)
    }
    

    @IBAction func deleteAccountTapped(_ sender: AnyObject) {
        
        // prompt if user want to delete account
        let remain = UIAlertController(title:"T T", message:"I will miss you", preferredStyle:UIAlertControllerStyle.alert)
        
        let stayAction = UIAlertAction(title:"Stay with me", style:UIAlertActionStyle.default,handler:nil)
        remain.addAction(stayAction)
        
        let deleteAction = UIAlertAction(title:"Delete cruelly", style:UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) in
            
            // delete AppUser and log out
            let realm1 = try! Realm()
            try! realm1.write {
                realm1.delete(self.user!)
            }
            self.logoutButtonTapped(self)
        })
        remain.addAction(deleteAction)
        
        self.present(remain, animated: true, completion: nil)

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChangePassword" {
            let change = segue.destination as! ChangePasswordViewController
            change.user = self.user
        }
        else if segue.identifier == "toEditUserProfile" {
            let edit = segue.destination as! EditUserProfileViewController
            edit.user = self.user
        }
        
    }


}
