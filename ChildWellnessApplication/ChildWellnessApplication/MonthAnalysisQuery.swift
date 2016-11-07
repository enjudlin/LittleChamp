//
//  MonthAnalysisQuery.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 11/6/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

class MonthAnalysisQuery: DataAnalysisQuery{
    func monthData()->[WeekDataObject]{
        var container = [WeekDataObject]()
        //The start date for the first week is 6 days before the given start date
        var weekStart = self.startDate.previousDate(numberOfDays: 6)
        container.append(self.weekCounts(startDate: weekStart))
        //Get data for previous 3 weeks
        for _ in 1...3{
            //The start date of the next week is 7 days before
            weekStart = weekStart.previousDate(numberOfDays: 7)
            container.append(weekCounts(startDate: weekStart))
        }
        //Reverse this, because its built backwards
        return container.reversed()
    }
    
    private func weekCounts(startDate: Date)->WeekDataObject{
        var date = startDate.previousDate(numberOfDays: 1)
        var subElementCounts = Array(repeating: 0.0, count: 5)
        //Get data for the start date and next 6 days
        for _ in 0...6{
            date = date.nextDayAt(hours: 0, minutes: 0)
            //Add the subElement count for that day
            for (i, subElementCount) in self.subElementCounts(date: date).enumerated(){
                subElementCounts[i] += subElementCount
            }
        }
        //Create a date formatter to figure out what the start date is as a string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        
        return WeekDataObject(startDate: dateFormatter.string(from: startDate), subElementCounts: subElementCounts)
    }
}

class WeekDataObject{
    //The start date of the week as a string in the form "mm/dd"
    var startDateString: String
    //The sum of the sub elements within that week
    var subElementCounts: [Double]
    
    init(startDate: String, subElementCounts: [Double]) {
        self.startDateString = startDate
        self.subElementCounts = subElementCounts
    }
    
    class func combineArrays(weekData: [WeekDataObject])->([String], [[Double]]){
        var labels = [String]()
        var values = [[Double]]()
        for ( _ , obj) in weekData.enumerated(){
            labels.append(obj.startDateString)
            values.append(obj.subElementCounts)
        }
        
        return (labels, values)
    }

}
