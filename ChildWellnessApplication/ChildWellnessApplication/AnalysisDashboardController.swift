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
                destination.days = ["12am-6am","6am-12pm","12pm-6pm","6pm-12am"]
                destination.dayOccur0 = (dayMatrix?[0])!
                destination.dayOccur1 = (dayMatrix?[1])!
                destination.dayOccur2 = (dayMatrix?[2])!
                destination.dayOccur3 = (dayMatrix?[3])!
                destination.dayOccur4 = (dayMatrix?[4])!
                
                
                
                let weekObject = child?.analysisLogic().weekDate(startDate: startDate.date, element: sendingButton.currentTitle!)
                let weekArrays = DayDataObject.combineArrays(weekData: weekObject!)
                destination.weeks = weekArrays.0
                var weekMatrix = weekArrays.1
                destination.weekOccur0 = (weekMatrix[0])
                destination.weekOccur1 = (weekMatrix[1])
                destination.weekOccur2 = (weekMatrix[2])
                destination.weekOccur3 = (weekMatrix[3])
                destination.weekOccur4 = (weekMatrix[4])
                destination.weekOccur5 = (weekMatrix[5])
                destination.weekOccur6 = (weekMatrix[6])
                
                
                
                let monthObject = child?.analysisLogic().monthData(startDate: startDate.date, element: sendingButton.currentTitle!)
                let monthArrays = WeekDataObject.combineArrays(weekData: monthObject!)
                destination.months = monthArrays.0
                var monthMatrix = monthArrays.1
                destination.monthOccur0 = (monthMatrix[0])
                destination.monthOccur1 = (monthMatrix[1])
                destination.monthOccur2 = (monthMatrix[2])
                destination.monthOccur3 = (monthMatrix[3])
                
            }
        }
    }
}
