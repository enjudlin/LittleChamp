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
    @IBOutlet weak var forgetPwdButton: UIButton!
    
    //This represents the user profile information to be sent onto other views
    var user: AppUser?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // check if remained logged in
        let realm = try! Realm()
        let loggedInUser = realm.objects(LoggedInUser.self)
        if loggedInUser.isEmpty {
            // do nothing
        } else {
            // check remained user data
            let temp = loggedInUser.first
            let email: String = (temp?.email)!
            let predicate = NSPredicate(format: "email = %@", email)
            self.user = realm.objects(AppUser.self).filter(predicate).first
            self.performSegue(withIdentifier: "FromLoginToChildren", sender: self)
        }
    }
    
    
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
            self.user = target
        }
        
        // ask user if they want to remain logged in
        let remain = UIAlertController(title:"Little Champ", message:"Do you want to remain logged in?", preferredStyle:UIAlertControllerStyle.alert)
        
        let yesAction = UIAlertAction(title:"Yes", style:UIAlertActionStyle.default,handler:{
            (action: UIAlertAction!) in
            
            let remain = LoggedInUser()
            remain.email = userEmail
            try! realm.write {
                realm.add(remain)
            }
            
            self.performSegue(withIdentifier: "FromLoginToChildren", sender: self)
        })
        remain.addAction(yesAction)
        
        let noAction = UIAlertAction(title:"No", style:UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) in
            self.performSegue(withIdentifier: "FromLoginToChildren", sender: self)
        })
        remain.addAction(noAction)
        
        self.present(remain, animated: true, completion: nil)
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
    
    @IBAction func forgetPwdButtonTapped(_ sender: AnyObject) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "FromLoginToChildren"){
            let navController = segue.destination as? UINavigationController
            let controller = navController?.viewControllers.first as? ChildProfileTableViewController
            controller?.user = self.user
        }
    }
 

}
