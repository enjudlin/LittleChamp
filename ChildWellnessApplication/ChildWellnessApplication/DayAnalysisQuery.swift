//
//  DayAnalysisQuery.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 11/4/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation

class DayAnalysisQuery: DataAnalysisQuery{
    
    /*The startDate and element variables are members through the initializer in the base class*/
    
    /*Get the count of records on the given day with the given element for each of the time intervals [midnight-6), [6-noon), [noon-6), [6- midnight). This returns an array of arrays of doubles, where the first array is the first subElement's counts in each time interval, the second is the second subelement, etc */
    func dayData()->[[Double]]{
        //Get records from the given day with the element present
        let dayRecords = recordsFromDay(date: self.startDate)
        
        //Create the containing array that the data arrays will be added to
        var containerArray = [[Double]]()
        
        //Generate the sub array for each sub element. This uses special syntax for an enumerated for loop so that the elements of the array must be accessed in order
        for (_, subElement) in (self.subElementStrings?.enumerated())! {
            //Further filter the day's records for only those with the element present
            let subElementRecords = dayRecords.filter( subElementPresentPredicate(subElement: subElement))
            //Generate an array of all of the appropriate time intervals
            let subElementArray = [timeIntervalCount(startHour: 0, endHour: 6, records: subElementRecords), timeIntervalCount(startHour: 6, endHour: 12, records: subElementRecords), timeIntervalCount(startHour: 12, endHour: 18, records: subElementRecords), timeIntervalCount(startHour: 18, endHour: 24, records: subElementRecords)]
            //Append to the container array
            containerArray.append(subElementArray)
        }
        
        return containerArray
    }
    
}
