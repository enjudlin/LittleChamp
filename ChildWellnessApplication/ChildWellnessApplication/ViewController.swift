//
//  ViewController.swift
//  ChildWellnessApplication
//
//  Created by Chen Rong on 9/26/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "toLoginView", sender: self)
    }

}

