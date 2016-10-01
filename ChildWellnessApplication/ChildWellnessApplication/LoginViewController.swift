//
//  LoginViewController.swift
//  ChildWellnessApplication
//
//  Created by Chen Rong on 10/1/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtionTapped(_ sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let password = passwordTextField.text
        
        // expected to have server side login function
        
        // local user login
        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail")
        let userPassowrdStored = UserDefaults.standard.string(forKey: "password")
        
        if userEmailStored == userEmail {
            if userPassowrdStored == password {
                // login is successful
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
            }
        }
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
