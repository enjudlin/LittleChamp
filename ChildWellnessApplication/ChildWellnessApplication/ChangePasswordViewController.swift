//
//  ChangePasswordViewController.swift
//  ChildWellnessApplication
//
//  Created by Chen Rong on 11/15/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit
import RealmSwift

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPwdTF: UITextField!
    @IBOutlet weak var newPwdTF: UITextField!
    @IBOutlet weak var rptPwdTF: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var user: AppUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        
        let oldpwd = oldPwdTF.text
        let newpwd = newPwdTF.text
        let rptpwd = rptPwdTF.text
        
        if oldpwd!.isEmpty || newpwd!.isEmpty || rptpwd!.isEmpty {
            displayAlertMessage(userMessage: "All fields required")
            return;
        }
        
        if oldpwd != user?.password {
            displayAlertMessage(userMessage: "Wrong old password")
            return;
        }
        
        if (newpwd?.characters.count)! < 8 {
            displayAlertMessage(userMessage: "Password length must be longer thatn 8")
            return;
        }
        
        if newpwd != rptpwd {
            displayAlertMessage(userMessage: "New password does not match")
            return;
        }
        
        // store new password
        let realm = try! Realm()
        try! realm.write {
            user?.password = newpwd
        }
        
        // display changing password successfully confirmation
        displayAlertMessage(userMessage: "Updating password successfully")
    }

    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "^_^", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        // need to change the alertActionStyle to match our UI later if time allows
        let okAction = UIAlertAction(title: "ok", style:UIAlertActionStyle.default, handler:nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion:nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
