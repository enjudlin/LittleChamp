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
    
    override func viewDidLayoutSubviews() {
        // make only textfields' bottom side visible
        let emailBorder = CALayer()
        let passwordBorder = CALayer()
        let width = CGFloat(1.5)
        
        emailBorder.borderColor = UIColor.white.cgColor
        emailBorder.frame = CGRect(x: 0, y: userEmailTextField.frame.size.height - width, width:  userEmailTextField.frame.size.width, height: userEmailTextField.frame.size.height)
        emailBorder.borderWidth = width
        passwordBorder.borderColor = UIColor.white.cgColor
        passwordBorder.frame = CGRect(x: 0, y: passwordTextField.frame.size.height - width, width:  passwordTextField.frame.size.width, height: passwordTextField.frame.size.height)
        passwordBorder.borderWidth = width
        
        userEmailTextField.layer.addSublayer(emailBorder)
        userEmailTextField.layer.masksToBounds = true

        passwordTextField.layer.addSublayer(passwordBorder)
        passwordTextField.layer.masksToBounds = true
    }
    
    
    @IBAction func loginButtionTapped(_ sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let password = passwordTextField.text
        
        // expected to have server side login
        
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
