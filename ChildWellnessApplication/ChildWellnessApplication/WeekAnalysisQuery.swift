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
    
    /*Get an array of the sub element counts that day*/
    func subElementCounts(date: Date)->[Double]{
        //Get the records for the given day, pre filtered by the element
        let dayRecords = self.recordsFromDay(date: date)
        var array = [Double]()
        //Use the special syntax for the for in loop to guarantee that array elements are accessed in order
        for (_, subElement) in self.subElementStrings!.enumerated(){
            //Further filter the day's records for only those with the element present
            let subElementRecords = dayRecords.filter( subElementPresentPredicate(subElement: subElement))
            //Add the count to the array
            array.append(Double(subElementRecords.count))
        }
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
}
