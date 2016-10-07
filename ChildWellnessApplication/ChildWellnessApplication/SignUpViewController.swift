//
//  SignUpViewController.swift
//  ChildWellnessApplication
//
//  Created by Chen Rong on 9/27/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
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
        let repeatpwdBorder = CALayer()
        let width = CGFloat(1.5)
        
        emailBorder.borderColor = UIColor.white.cgColor
        emailBorder.frame = CGRect(x: 0, y: userEmailTextField.frame.size.height - width, width:  userEmailTextField.frame.size.width, height: userEmailTextField.frame.size.height)
        emailBorder.borderWidth = width
        
        passwordBorder.borderColor = UIColor.white.cgColor
        passwordBorder.frame = CGRect(x: 0, y: userPasswordTextField.frame.size.height - width, width: userPasswordTextField.frame.size.width, height: userPasswordTextField.frame.size.height)
        passwordBorder.borderWidth = width
        
        repeatpwdBorder.borderColor = UIColor.white.cgColor
        repeatpwdBorder.frame = CGRect(x: 0, y: repeatPasswordTextField.frame.size.height - width, width: repeatPasswordTextField.frame.size.width, height: repeatPasswordTextField.frame.size.height)
        repeatpwdBorder.borderWidth = width
        
        userEmailTextField.layer.addSublayer(emailBorder)
        userEmailTextField.layer.masksToBounds = true
        
        userPasswordTextField.layer.addSublayer(passwordBorder)
        userPasswordTextField.layer.masksToBounds = true
        
        repeatPasswordTextField.layer.addSublayer(repeatpwdBorder)
        repeatPasswordTextField.layer.masksToBounds = true
    }
    

    @IBAction func registerButtonTapped(_ sender: AnyObject) {

        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let userReaptPwd = repeatPasswordTextField.text;
        
        // check for empty fields
        if userEmail!.isEmpty || userPassword!.isEmpty || userReaptPwd!.isEmpty {
            // display alert message
            displayAlertMessage(userMessage: "All fields are required.")
            return;
        }
        
        if userPassword != userReaptPwd {
            // display alert message
            displayAlertMessage(userMessage: "Passwords do not match.")
            return;
        }
        
        // store data locally, no server side codes for now
        UserDefaults.standard.set(userEmail, forKey:"userEmail")
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        UserDefaults.standard.synchronize()
        
        // display confirmation successful alert
        let myAlert = UIAlertController(title:"Alert", message: "Registration is successful.", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "ok", style:UIAlertActionStyle.default) {
            action in self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
    
    // display alert message with confirmation
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
            
        let okAction = UIAlertAction(title: "ok", style:UIAlertActionStyle.default, handler:nil)
        
        myAlert.addAction(okAction)
            
        self.present(myAlert, animated: true, completion:nil)
        
    }

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Navigation
    

}
