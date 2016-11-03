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
    
    //Smarty Data
    var child: AppChild?
    var startDate: Date?
    var subElement: String?
    
    
    //Dummy Data
    var months = ["Jan", "Feb", "Mar", "Apr", "May"]
    var days = ["Mon", "Tues", "Weds", "Thur", "Fri"]
    var weeks = ["10/21","10/28","11/4","11/11","11/18"]
    var occur0 = [1.0,4.0,2.0,6.0,2.0]
    var occur1 = [2.0,8.0,1.0,3.0,3.0]
    var occur2 = [9.0,4.0,2.0,1.0,6.0]
    var occur3 = [2.0,3.0,7.0,1.0,4.0]
    var occur4 = [6.0,4.0,3.0,5.0,1.0]
    
    //MARK: Outlets
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
        setChart(labels: days, data0: occur0, data1: occur1, data2: occur2, data3: occur3, data4: occur4)
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
    
    func setChart(labels: [String], data0: [Double], data1: [Double], data2: [Double], data3: [Double], data4: [Double]){
        
        
        
        var dataEntries0: [ChartDataEntry] = []
        var dataEntries1: [ChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []
        var dataEntries3: [ChartDataEntry] = []
        var dataEntries4: [ChartDataEntry] = []
        
        
        for i in 0..<labels.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: data0[i])
            dataEntries0.append(dataEntry)
        }
        for i in 0..<labels.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: data1[i])
            dataEntries1.append(dataEntry)
        }
        for i in 0..<labels.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: data2[i])
            dataEntries2.append(dataEntry)
        }
        for i in 0..<labels.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: data3[i])
            dataEntries3.append(dataEntry)
        }
        for i in 0..<labels.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: data4[i])
            dataEntries4.append(dataEntry)
        }
        
        
        let set0 = LineChartDataSet(values: dataEntries0, label: label0.text)
        let set1 = LineChartDataSet(values: dataEntries1, label: label1.text)
        let set2 = LineChartDataSet(values: dataEntries2, label: label2.text)
        let set3 = LineChartDataSet(values: dataEntries3, label: label3.text)
        let set4 = LineChartDataSet(values: dataEntries4, label: label4.text)
        
        
        set0.setColor(UIColor.red)
        set1.setColor(UIColor.orange)
        set2.setColor(UIColor.yellow)
        set3.setColor(UIColor.green)
        set4.setColor(UIColor.blue)
        
        
        var dataSets = [LineChartDataSet]()
        dataSets.append(set0)
        dataSets.append(set1)
        dataSets.append(set2)
        dataSets.append(set3)
        dataSets.append(set4)
        
        
        let data = LineChartData(dataSets: dataSets)
        lineChartView.data = data
        
        
    }
    
}
