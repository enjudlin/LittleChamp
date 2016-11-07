//
//  WeekAnalysisQuery.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 11/4/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

class WeekAnalysisQuery: DataAnalysisQuery{
    
    /*Generate the expected query data. This will consist of 7 DayData objects of days in chronological order*/
    func weekData()->[DayDataObject]{
        var array = [DayDataObject]()
        //Generate day data for previous 6 days
        for i in 1...6{
            let previousDate = self.startDate.previousDate(numberOfDays: i)
            array.append(DayDataObject(weekday: self.weekdayString(date: previousDate), subElementCounts: subElementCounts(date: previousDate)))
        }
        //Reverse the array because Swift ranges cannot be generated in reverse order
        array.reverse()
        //Generate day data for the start date
        array.append(DayDataObject(weekday: self.weekdayString(date: self.startDate), subElementCounts: self.subElementCounts(date: self.startDate)))
        return array
    }
    
}

class DayDataObject{
    //The weekday label ("Mon", "Tues" etc)
    var weekday = ""
    //The counts of each subelement for that day in the format [sub element 1 count, sub element 2 count, ...]
    var subElementCounts = [Double]()
    init(weekday: String, subElementCounts: [Double]){
        self.weekday = weekday
        self.subElementCounts = subElementCounts
    }
    
    //Compare contents of the day data object
    func equal(data: DayDataObject)->Bool{
        return self.weekday == data.weekday && self.subElementCounts == data.subElementCounts
    }
    
    /*Helper to convert and array of this object into two arrays, one of the labels and another of the arrays of counts.
     Since this is a multiple return, it should be called in the format:
     let (labelArray, valueArray) = DayDataObject.combineArrays(...
     */
    class func combineArrays(weekData: [DayDataObject])->([String], [[Double]]){
        var labels = [String]()
        var values = [[Double]]()
        for ( _ , obj) in weekData.enumerated(){
            labels.append(obj.weekday)
            values.append(obj.subElementCounts)
        }
        
        return (labels, values)
    }
}
