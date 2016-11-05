//
//  DateExtensions.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 11/3/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation

//Date extensions. The inspiration for this came from stackoverflow.com/questions/29652771/how-to-check-if-time-is-within-a-specific-range-in-swift
extension Date
{
    /**
     This adds a new method dateAt to NSDate.
     
     It returns a new date at the specified hours and minutes of the receiver
     
     :param: hours: The hours value
     :param: minutes: The new minutes
     
     :returns: a new Date with the same year/month/day as the receiver, but with the specified hours/minutes values
     */
    func dateAt(hours: Int, minutes: Int) -> Date
    {
        let calendar = NSCalendar.current
        
        //get the month/day/year componentsfor today's date.
        
        let components: Set<Calendar.Component> = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day]
        var dateComponents = calendar.dateComponents(components, from: self)
        
        //Create an Date the time given
        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = 0
        
        let newDate = calendar.date(from: dateComponents)
        return newDate!
    }
    
    /*Generate the following date*/
    func nextDayAt(hours: Int, minutes: Int)->Date{
        let calendar = NSCalendar.current
        var dateComponents = DateComponents()
        dateComponents.day = 1
        let nextDay = calendar.date(byAdding: dateComponents, to: self)
        return (nextDay?.dateAt(hours: hours, minutes: minutes))!
    }
}
