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
    var child: Child?
    var startDate: Date?
    var subElement: String?
    
    
    //Dummy Data
    //X axis values
    var days: [String]?
    var weeks: [String]?
    var months: [String]?
    
    //variable number indicates which subsection of the topic (subElement variable), position in array is week number as it should be displayed (first is farthest back in time) number is number of occurances
    //Y Axis Values
    //Excessively Active || Temper Tantrums || Argue With Others || Unresponsive when spoken to
    var monthOccur0: [Double]?
    //Abnormal Repetitive || Depressed Mood || Defiant || Talk Excessively
    var monthOccur1: [Double]?
    //Self Injury || Lacks Emotional Response || Withdrawn || Does not try to communicate
    var monthOccur2: [Double]?
    //Sluggish, inactive || Excessive crying || Resist Physical Contact || Talks to self loudly
    var monthOccur3: [Double]?
    //Screams Inappropriatly || Mood Changes Quickly || Physically Hurts Others || Difficulty Expressing self
    var monthOccur4: [Double]?
    
    //Time buckets
    //Excessively Active || Temper Tantrums || Argue With Others || Unresponsive when spoken to
    var dayOccur0: [Double]?
    //Abnormal Repetitive || Depressed Mood || Defiant || Talk Excessively
    var dayOccur1: [Double]?
    //Self Injury || Lacks Emotional Response || Withdrawn || Does not try to communicate
    var dayOccur2: [Double]?
    //Sluggish, inactive || Excessive crying || Resist Physical Contact || Talks to self loudly
    var dayOccur3: [Double]?
    //Screams Inappropriatly || Mood Changes Quickly || Physically Hurts Others || Difficulty Expressing self
    var dayOccur4: [Double]?
    
    //There should be 7
    //Excessively Active || Temper Tantrums || Argue With Others || Unresponsive when spoken to
    var weekOccur0: [Double]?
    //Abnormal Repetitive || Depressed Mood || Defiant || Talk Excessively
    var weekOccur1: [Double]?
    //Self Injury || Lacks Emotional Response || Withdrawn || Does not try to communicate
    var weekOccur2: [Double]?
    //Sluggish, inactive || Excessive crying || Resist Physical Contact || Talks to self loudly
    var weekOccur3: [Double]?
    //Screams Inappropriatly || Mood Changes Quickly || Physically Hurts Others || Difficulty Expressing self
    var weekOccur4: [Double]?
    
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
            labels = days!
            data0 = dayOccur0!
            data1 = dayOccur1!
            data2 = dayOccur2!
            data3 = dayOccur3!
            data4 = dayOccur4!
        }
        else if timePeriodPicker.selectedSegmentIndex == 1{
            labels = weeks!
            data0 = weekOccur0!
            data1 = weekOccur1!
            data2 = weekOccur2!
            data3 = weekOccur3!
            data4 = weekOccur4!
        }
        else{
            labels = months!
            data0 = monthOccur0!
            data1 = monthOccur1!
            data2 = monthOccur2!
            data3 = monthOccur3!
            data4 = monthOccur4!
            
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
            lineChartView.xAxis.valueFormatter = MyXAxisFormatter(label: days!)
        }
        else if timePeriodPicker.selectedSegmentIndex == 1{
            lineChartView.xAxis.valueFormatter = MyXAxisFormatter(label: weeks!)
        }
        else{
            lineChartView.xAxis.valueFormatter = MyXAxisFormatter(label: months!)
        }
        lineChartView.xAxis.granularity = 1.0
        lineChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
    }
    
    
    @IBAction func toggleChart0(_ sender: AnyObject) {
                setChart()
    }
    
}
