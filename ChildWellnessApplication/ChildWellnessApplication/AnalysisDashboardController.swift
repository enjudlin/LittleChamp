//
//  AnalysisDashboardController.swift
//  ChildWellnessApplication
//
//  Created by Guest User on 11/2/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit

class AnalysisDashboardController: UIViewController {
    @IBOutlet weak var startDate: UIDatePicker!
    var child: AppChild?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    func prepare(for segue: UIStoryboardSegue, sender: UIButton?) {
        if let destination = segue.destination as? AnalysisChartController{
            destination.startDate = startDate.date
            destination.subElement = sender?.currentTitle
            destination.child = child
        }
    }
}
