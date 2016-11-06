//
//  AnalysisLogicFactory.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 11/4/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation

/*The logic to analyze the data is quite complicated and does not really belong in the Child Model. Instead, the business logic of data analysis is abstracted into DataAnalysisQuery subclasses. This class uses the Factory Pattern to allow easy access to this information*/
class AnalysisLogicFactory{
    //MARK: Properties
    var appChild: AppChild
    
    //MARK: Constructor
    init(appChild: AppChild) {
        self.appChild = appChild
    }
    
    //MARK: Analysis methods
    
    /*Get the data for the "Day" frequency chart. This data is returned as an array of arrays in the format:
     [[subElement 1 counts for each interval], [sub element 2 counts for each interval]....]
     */
    func dayData(startDate: Date, element: String)->[[Double]]{
        return DayAnalysisQuery(appChild: self.appChild, startDate: startDate, element: element).dayData()
    }
    
    /*Generate the expected query data. This will consist of 7 DayData objects of days in chronological order*/
    func weekDate(startDate: Date, element: String)->[DayDataObject]{
        return WeekAnalysisQuery(appChild: self.appChild, startDate: startDate, element: element).weekData()
    }
    
    /*Generate the data for a month, in the form of an array of week data objects in chronological order*/
    func monthData(startDate: Date, element: String)->[WeekDataObject]{
        return MonthAnalysisQuery(appChild: self.appChild, startDate: startDate, element: element).monthData()
    }
}
