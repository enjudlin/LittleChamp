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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
}
