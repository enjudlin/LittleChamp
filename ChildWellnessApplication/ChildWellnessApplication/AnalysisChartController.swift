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
    var days = ["12am", "6am", "12pm", "6pm", "12am"]
    var weeks = ["Mon", "Tues", "Weds", "Thur", "Fri"]
    var months = ["10/21","10/28","11/4","11/11","11/18"]
    
    
    var monthOccur0 = [1.0,4.0,2.0,6.0,2.0]
    var monthOccur1 = [2.0,8.0,1.0,3.0,3.0]
    var monthOccur2 = [9.0,4.0,2.0,1.0,6.0]
    var monthOccur3 = [2.0,3.0,7.0,1.0,4.0]
    var monthOccur4 = [6.0,4.0,3.0,5.0,1.0]
    
    var dayOccur0 = [4.0,2.0,1.0,8.0,4.0]
    var dayOccur1 = [3.0,1.0,1.0,6.0,2.0]
    var dayOccur2 = [7.0,4.0,3.0,1.0,8.0]
    var dayOccur3 = [3.0,9.0,4.0,1.0,7.0]
    var dayOccur4 = [2.0,1.0,5.0,9.0,0.0]
    
    var weekOccur0 = [2.0,1.0,2.0,0.0,4.0]
    var weekOccur1 = [6.0,3.0,1.0,1.0,1.0]
    var weekOccur2 = [0.0,0.0,2.0,1.0,2.0]
    var weekOccur3 = [1.0,5.0,2.0,8.0,2.0]
    var weekOccur4 = [7.0,0.0,0.0,5.0,3.0]
    
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
        setChart()
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
    
    func setChart(){
        var labels = [String]()
        var data0 = [Double]()
        var data1 = [Double]()
        var data2 = [Double]()
        var data3 = [Double]()
        var data4 = [Double]()
        
        
        if timePeriodPicker.selectedSegmentIndex == 0{
            labels = days
            data0 = dayOccur0
            data1 = dayOccur1
            data2 = dayOccur2
            data3 = dayOccur3
            data4 = dayOccur4
        }
        else if timePeriodPicker.selectedSegmentIndex == 1{
            labels = weeks
            data0 = weekOccur0
            data1 = weekOccur1
            data2 = weekOccur2
            data3 = weekOccur3
            data4 = weekOccur4
        }
        else{
            labels = months
            data0 = monthOccur0
            data1 = monthOccur1
            data2 = monthOccur2
            data3 = monthOccur3
            data4 = monthOccur4
            
        }
        
        
        
        
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
        
        set0.drawValuesEnabled = false
        set1.drawValuesEnabled = false
        set2.drawValuesEnabled = false
        set3.drawValuesEnabled = false
        set4.drawValuesEnabled = false
        
        set0.circleRadius = 2
        set1.circleRadius = 2
        set2.circleRadius = 2
        set3.circleRadius = 2
        set4.circleRadius = 2
        
        
        var dataSets = [LineChartDataSet]()
        if switch0.isOn{
            dataSets.append(set0)
        }
        if switch1.isOn{
            dataSets.append(set1)
        }
        if switch2.isOn{
            dataSets.append(set2)
        }
        if switch3.isOn{
            dataSets.append(set3)
        }
        if switch4.isOn{
            dataSets.append(set4)
        }
        
        
        let data = LineChartData(dataSets: dataSets)
        lineChartView.data = data
        if timePeriodPicker.selectedSegmentIndex == 0{
            lineChartView.xAxis.valueFormatter = MyXAxisFormatter(label: days)
        }
        else if timePeriodPicker.selectedSegmentIndex == 1{
            lineChartView.xAxis.valueFormatter = MyXAxisFormatter(label: weeks)
        }
        else{
            lineChartView.xAxis.valueFormatter = MyXAxisFormatter(label: months)
        }
        lineChartView.xAxis.granularity = 1.0
        lineChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
    }
    
    
    @IBAction func toggleChart0(_ sender: AnyObject) {
                setChart()
    }
    
}
