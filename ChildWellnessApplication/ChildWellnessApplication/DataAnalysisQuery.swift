//
//  DataAnalysisQuery.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 11/4/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

/*This is the base class for data analysis queries. By having all of the classes inherit from this class, shared logic can be abstracted here.*/
class DataAnalysisQuery{
    //MARK: Properties
    //Make the data that is going to be needed for all classes member variables
    var appChild: AppChild?
    var startDate: Date?
    var element: String?
    var subElementStrings: [String]?
    var calendar = NSCalendar.init(identifier: NSCalendar.Identifier.gregorian)
    
    //MARK: Constructor
    init(appChild: AppChild, startDate: Date, element: String) {
        self.appChild = appChild
        self.startDate = startDate
        self.element = element
        self.subElementStrings = subElementStringArray(element: element)
    }
    
    //MARK: Helper Methods
    
    //Generate the proper element predicate from a string
    func elementPredicate(element: String)-> NSPredicate{
        return NSPredicate(format: element.lowercased() + "!= nil")
    }
    
    //Generate the predicate for a subelement being "present" (not marked as N/A)
    func subElementPresentPredicate(subElement: String)->NSPredicate{
        return NSPredicate(format: subElement + "!= 3")
    }
    
    /*Get the subElementString array from the given element. Returns an array of a single empty string if the element is not found*/
    func subElementStringArray(element: String)->[String]{
        var subElements: [String]
        switch element {
        case "Activity":
            subElements = ActivityObject.subElementStrings
        case "Social":
            subElements = SocialObject.subElementStrings
        case "Communication":
            subElements = CommunicationObject.subElementStrings
        case "Emotion":
            subElements = EmotionObject.subElementStrings
        default:
            subElements = [""]
        }
        return subElements
    }
    
    /*Function to determine if the date object's time is within a time interval on the same day.
     This assumes that the time interval starts and ends exactly on the hour.
     startHour and endHour should be expressed using a 24 hour clock.
     The startHour is inclusive and the endHour is exclusive, so that records are not double counted*/
    func isInTimeInterval(date: Date, startHour: Int, endHour: Int)->Bool{
        let startDate = date.dateAt(hours: startHour, minutes: 0)
        let endDate = date.dateAt(hours: endHour, minutes: 0)
        return date >= startDate && date < endDate
    }
    
    /*Create a predicate for the interval between the two hours*/
    func intervalPredicate(startHour: Int, endHour: Int)->NSPredicate{
        return NSPredicate { (record, bindings)->Bool in
            let recordObject = record as! RecordObject
            return self.isInTimeInterval(date: recordObject.dateCreated, startHour: startHour, endHour: endHour)
        }
    }
    
    /*Get the count of records in the interval as a double*/
    func timeIntervalCount(startHour: Int, endHour: Int, records: Results<RecordObject>)->Double{
        let intervalPredicate = self.intervalPredicate(startHour: 0, endHour: 6)
        let intervalRecords = records.filter(intervalPredicate)
        return Double((intervalRecords.count))
    }
    
    
}
