//
//  UserProfileViewController.swift
//  ChildWellnessApplication
//
//  Created by Chen Rong on 11/15/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var changePwdButton: UIButton!
    var user: AppUser?
    
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
        if segue.identifier == "toChangePassword" {
            let change = segue.destination as! ChangePasswordViewController
            change.user = self.user
        }
        
    }


}
