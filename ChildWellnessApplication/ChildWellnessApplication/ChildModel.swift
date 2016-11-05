//
//  ChildModel.swift
//  ChildWellnessApplication
//
//  Created by kampen, samuel scott on 9/27/16.
//  Copyright (c) 2016 group6. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Child{
    // MARK: Properties
    var name: String
    var gender: String
    var age: Int
    var birthDateString: String
    var birthDate: Date
    var parent: AppUser
    var appChild: AppChild?
    
    // Mark: Initialization
    
    //Initialization method for a Child Object
    //
    //Requires: name is a String containing the childs name
    //          gender is the string "male" or "female"
    //          birthDate is a Date object
    //
    //Ensures: The object returned is a Child object
    required init?(name: String, gender: String, birthDate: Date, parent: AppUser){
        self.age = 0 //This is a temporary initialization, it will be set properly by the calcAge method
        self.parent = parent
        if name.isEmpty {
            return nil
        }else{
            self.name = name
        }
        
        if gender == "male" || gender == "female"{
            self.gender = gender
        }
        else{
            return nil
        }
        self.birthDate = birthDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.birthDateString = dateFormatter.string(from: birthDate)
        calcAge()
    }
    
    //Alternate implementation for when the child is already saved in the database
    init(appChild: AppChild) {
        self.appChild = appChild
        self.age = 0
        self.parent = appChild.parent!
        self.name = appChild.name
        self.gender = appChild.gender
        self.birthDate = appChild.birthdate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.birthDateString = dateFormatter.string(from: birthDate)
        calcAge()
    }
    
    func calcAge(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.unitsStyle = DateComponentsFormatter.UnitsStyle.full
        let interval = NSDate().timeIntervalSince(self.birthDate)
        let ageString = dateComponentsFormatter.string(from: interval)
        let delimiter = " "
        var token = ageString!.components(separatedBy: delimiter)
        let ageScale = token[1]
        self.age = Int(token[0])!
        if(ageScale != "years,"){
            self.age = 0
        }
    }
    
    func createChild(){
        let realm = try! Realm()
        let appChild = AppChild()
        appChild.name = self.name
        appChild.birthdate = self.birthDate
        appChild.gender = self.gender
        appChild.parent = self.parent
        try! realm.write{
            realm.add(appChild)
        }
    }
    
    //Function that will update a child in the realm database
    //child is a child object with the properties of the updated child
    //name is a string representing the name of the child currently in the database
    func updateChild(child: Child, name: String){
        let realm = try! Realm()
        let predicate = NSPredicate(format: "name = %@", name)
        let childToUpdate = realm.objects(AppChild.self).filter(predicate).first
        try! realm.write {
            childToUpdate!.name = child.name
            childToUpdate!.gender = child.gender
            childToUpdate!.birthdate = child.birthDate
        }
    }
    
    //MARK: Analysis Queries
    
    //Helper: Generate the proper element predicate from a string
    func elementPredicate(element: String)-> NSPredicate{
        return NSPredicate(format: element.lowercased() + "!= nil")
    }
    
    //Helper: Generate the predicate for a subelement being "present" (not marked as N/A)
    func subElementPresentPredicate(subElement: String)->NSPredicate{
        return NSPredicate(format: subElement + "!= 3")
    }
    
    /*Helper: Get the subElementString array from the given element. Returns an array of a single empty string if the element is not found*/
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
    
    func monthData(startDate: Date, element: String){
        
    }
    
    /*Get an array of the */
    func weekData(startDate: Date, element: String){
        
    }
    
    /*Helper: function to determine if the date object's time is within a time interval on the same day.
     This assumes that the time interval starts and ends exactly on the hour.
     startHour and endHour should be expressed using a 24 hour clock.
     The startHour is inclusive and the endHour is exclusive, so that records are not double counted*/
    func isInTimeInterval(date: Date, startHour: Int, endHour: Int)->Bool{
        let startDate = date.dateAt(hours: startHour, minutes: 0)
        let endDate = date.dateAt(hours: endHour, minutes: 0)
        return date >= startDate && date < endDate
    }

    /*Helper: Create a predicate for the interval between the two hours*/
    func intervalPredicate(startHour: Int, endHour: Int)->NSPredicate{
        return NSPredicate { (record, bindings)->Bool in
            let recordObject = record as! RecordObject
            return self.isInTimeInterval(date: recordObject.dateCreated, startHour: startHour, endHour: endHour)
        }
    }
    
    /*Helper: Get the count of records in the interval as a double*/
    func timeIntervalCount(startHour: Int, endHour: Int, records: Results<RecordObject>)->Double{
        let intervalPredicate = self.intervalPredicate(startHour: 0, endHour: 6)
        let intervalRecords = records.filter(intervalPredicate)
        return Double((intervalRecords.count))
    }
    
    /*Get the count of records on the given day with the given element for each of the time intervals [midnight-6), [6-noon), [noon-6), [6- midnight). This returns an array of arrays of doubles, where the first array is the first subElement's counts in each time interval, the second is the second subelement, etc */
    func dayData(startDate: Date, element: String)->[[Double]]{
        let calendar = NSCalendar.current
        //This uses Swift's closure to leverage the NSCalendar class
        let dayPredicate = NSPredicate { (record, bindings)->Bool in
            let recordObject = record as! RecordObject
            return calendar.isDate(recordObject.dateCreated, inSameDayAs: startDate)
        }
        //Get records from the given day with the element present
        let dayRecords = self.appChild?.records.filter(dayPredicate).filter(elementPredicate(element: element))
        
        //Create the containing array that the data arrays will be added to
        var containerArray = [[Double]]()
        
        //Get the sub elements for the element
        let subElements = subElementStringArray(element: element)
        
        //Generate the sub array for each sub element. This uses special syntax for an enumerated for loop so that the elements of the array must be accessed in order
        for (_, subElement) in subElements.enumerated() {
            //Further filter the day's records for only those with the element present
            let subElementRecords = dayRecords?.filter( subElementPresentPredicate(subElement: subElement))
            //Generate an array of all of the appropriate time intervals
            let subElementArray = [timeIntervalCount(startHour: 0, endHour: 6, records: subElementRecords!), timeIntervalCount(startHour: 6, endHour: 12, records: subElementRecords!), timeIntervalCount(startHour: 12, endHour: 18, records: subElementRecords!), timeIntervalCount(startHour: 18, endHour: 0, records: subElementRecords!)]
            //Append to the container array
            containerArray.append(subElementArray)
        }

        return containerArray 
    }
    
}
