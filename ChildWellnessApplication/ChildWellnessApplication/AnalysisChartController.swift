//
//  AnalysisChartController.swift
//  ChildWellnessApplication
//
//  Created by Guest User on 11/2/16.
//  Copyright © 2016 group6. All rights reserved.
//


import UIKit
import Charts

class AnalysisChartController: UIViewController {
    
    
    var child: AppChild?
    var startDate: Date?
    var subElement: String?
    @IBOutlet weak var timePeriodPicker: UISegmentedControl!
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var switch0: UISwitch!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var switch4: UISwitch!
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func setLabels(){
        if subElement == "Activity"{
            label0.text = "Excessively Active"
            label1.text = "Abnormal Repetitive"
            label2.text = "Self-injury"
            label3.text = "Sluggish, inactive"
            label4.text = "Screams inappropriately"
        }
        else if subElement == "Emotion"{
            label0.text = "Temper tantrums"
            label1.text = "Depressed mood"
            label2.text = "Lacks emotional response"
            label3.text = "Excessive crying"
            label4.text = "Mood changes quickly"

        }
        else if subElement == "Social"{
            label0.text = "Argue with others"
            label1.text = "Defiant"
            label2.text = "Withdrawn"
            label3.text = "Resist physical contact"
            label4.text = "Physically hurt others"
            
        }
        else{
            label0.text = "Unresponsive when spoken to"
            label1.text = "Talk excessively"
            label2.text = "Does not try to communicate"
            label3.text = "Talks to self loudly"
            label4.text = "Difficulty expressing self"
        }
    }
    
}
