//
//  LoginViewController.swift
//  ChildWellnessApplication
//
//  Created by Chen Rong on 10/1/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
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
        
        // check for empty fields, invalid email form
        if userEmail!.isEmpty || password!.isEmpty {
            displayAlertMessage(userMessage: "All fields are required")
            return;
        }
        
        if isValidEmail(testStr: userEmail!) == false {
            displayAlertMessage(userMessage: "This is not a valid email form")
            return;
        }

        
        // login check
        let tempUser = AppUser()
        tempUser.email = userEmail
        tempUser.password = password
        let realm = try! Realm()

        let predicate = NSPredicate(format: "email = %@", userEmail!)
        let target = realm.objects(AppUser.self).filter(predicate).first

        if target == nil {
            displayAlertMessage(userMessage: "This account doesn't exist")
            return;
        } else {
            if target?.password != password {
                displayAlertMessage(userMessage: "Wrong password")
                return;
            }
            // login successful;
        }
    }

    /** 
     * display alert message with confirmation
     */
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        // need to change the alertActionStyle to match our UI later if time allows
        let okAction = UIAlertAction(title: "ok", style:UIAlertActionStyle.default, handler:nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion:nil)
    }

    /**
     * check if a string is in valid email form
     */
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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
