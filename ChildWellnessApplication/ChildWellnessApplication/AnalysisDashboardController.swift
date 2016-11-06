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
    var child: Child?
    
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
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AnalysisChartController{
            if let sendingButton = sender as? UIButton{
                destination.startDate = startDate.date
                destination.subElement = sendingButton.currentTitle
                destination.child = child
                var dayMatrix = child?.analysisLogic().dayData(startDate: startDate.date, element: sendingButton.currentTitle!)
                destination.dayOccur0 = (dayMatrix?[0])!
                destination.dayOccur1 = (dayMatrix?[1])!
                destination.dayOccur2 = (dayMatrix?[2])!
                destination.dayOccur3 = (dayMatrix?[3])!
                destination.dayOccur4 = (dayMatrix?[4])!
            
            
            }
        }
    }
}
