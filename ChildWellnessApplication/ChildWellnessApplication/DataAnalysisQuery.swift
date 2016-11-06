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
    var appChild: AppChild
    var startDate: Date
    var element: String
    //This is not actually optional, but must be initialized this way so that it can be set in the constructor
    var subElementStrings: [String]?
    let calendar = NSCalendar.init(identifier: NSCalendar.Identifier.gregorian)
    
    //MARK: Constructor
    init(appChild: AppChild, startDate: Date, element: String) {
        self.appChild = appChild
        self.startDate = startDate
        self.element = element
        self.subElementStrings = subElementStringArray(element: element)
    }
    
    //MARK: Helper Methods
    
    /*Helpful predicates*/
    
    //Generate the proper element predicate from a string
    func elementPredicate(element: String)-> NSPredicate{
        return NSPredicate(format: element.lowercased() + "!= nil")
    }
    
    //Generate the predicate for a subelement being "present" (not marked as N/A)
    func subElementPresentPredicate(subElement: String)->NSPredicate{
        return NSPredicate(format: self.element.lowercased() + "." + subElement + "!= 3")
    }
    
    /*Create a predicate for the interval between the two hours on the start date. End hour given as 24 is interpretted as the beginning of the following day*/
    func intervalPredicate(startHour: Int, endHour: Int)->NSPredicate{
        //This is a rather obtuse way of doing it because Realm doesn't support block predicates
        let endDate = (endHour == 24) ? self.startDate.nextDayAt(hours: 0, minutes: 0) :  self.startDate.dateAt(hours: endHour, minutes: 0)
        return NSPredicate(format: "dateCreated >= %@ AND dateCreated < %@", argumentArray: [self.startDate.dateAt(hours: startHour, minutes: 0), endDate])
    }
    
    /*The predicate for something being in the same day as the given date*/
    func dayPredicate(date: Date)->NSPredicate{
        //This would be more succinctly done with a closure (or using a block Predicate) but that is not supported by Realm at the moment
        return NSPredicate(format: "dateCreated >= %@ AND dateCreated < %@", argumentArray: [date.dateAt(hours: 0, minutes: 0), date.nextDayAt(hours: 0, minutes: 0)])    }
    
    /*Other helpers*/
    
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
     The startHour is inclusive and the endHour is exclusive, so that records are not double counted
     
     Special case: Use 24 for the end hour to indicate the beginning of the following day*/
    func isInTimeInterval(date: Date, startHour: Int, endHour: Int)->Bool{
        let startDate = date.dateAt(hours: startHour, minutes: 0)
        var endDate = date
        if (endHour == 24){
            endDate = date.nextDayAt(hours: 0, minutes: 0)
        }else{
            endDate = date.dateAt(hours: endHour, minutes: 0)
        }
        return date >= startDate && date < endDate
    }
    
    
    
    /*Get the count of records in the interval as a double*/
    func timeIntervalCount(startHour: Int, endHour: Int, records: Results<RecordObject>)->Double{
        let intervalPredicate = self.intervalPredicate(startHour: startHour, endHour: endHour)
        let intervalRecords = records.filter(intervalPredicate)
        return Double((intervalRecords.count))
    }
    
    /*Find the weekday of a Date object as a string in the format Mon, Tues, Wed, etc*/
    func weekdayString(date: Date)->String{
        let index = self.calendar!.component(NSCalendar.Unit.weekday, from: date)
        var str: String
        switch index {
        case 1:
            str = "Sun"
        case 2:
            str = "Mon"
        case 3:
            str = "Tues"
        case 4:
            str = "Wed"
        case 5:
            str = "Thurs"
        case 6:
            str = "Fri"
        case 7:
            str = "Sat"
        default:
            str = ""
        }
        return str
    }
    
    /*Get all of the records for that child on a given day, filtered by the selected element*/
    func recordsFromDay(date: Date)->Results<RecordObject>{
        return (self.appChild.records.filter(dayPredicate(date: date)).filter(elementPredicate(element: self.element)))
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
