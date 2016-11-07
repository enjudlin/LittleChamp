//
//  DataAnalysisQueryTest.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 11/5/16.
//  Copyright © 2016 group6. All rights reserved.
//

import XCTest
import RealmSwift
@testable import ChildWellnessApplication

class DataAnalysisQueryTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: Set up helpers
    func setUpObject()->DataAnalysisQuery{
        let appChild = AppChild()
        return DataAnalysisQuery(appChild: appChild, startDate: Date(), element: "Activity")
    }
    
    
    //MARK: Tests
    func testIsInTimeInterval(){
        let obj = setUpObject()
        var date = Date().dateAt(hours: 3, minutes: 15)
        //Standard case, 3:15 is between 3 and 4
        XCTAssertTrue(obj.isInTimeInterval(date: date, startHour: 3, endHour: 4), "3:15 not found to be between 3 and 4")
        //StandardCase, 3:15 is not between 5 and 7
        XCTAssertFalse(obj.isInTimeInterval(date: date, startHour: 5, endHour: 7), "3:15 found between 5 and 7")
        date = Date().dateAt(hours: 23, minutes: 59)
        //Special case: date is right at the end of the day
        XCTAssertTrue(obj.isInTimeInterval(date: date, startHour: 18, endHour: 24), "11:59 not found between 6 and the end of the day")
        date = Date().dateAt(hours: 0, minutes: 0)
        //Special case: date is right at the start of the day
        XCTAssertTrue(obj.isInTimeInterval(date: date, startHour: 0, endHour: 6))
    }
    
    func testRecordsFromDay(){
        let obj = setUpObject()
        //Place 3 records in today.
        for _ in 1...3{
            let record = RecordObject()
            record.child = obj.appChild
            //setUpObj sets the element to "Activity", so they will not be found unless an ActivityObject is found
            record.activity = ActivityObject()
            //The create method automatically sets the timestamp to now
            record.create()
        }
         XCTAssertEqual(obj.recordsFromDay(date: Date()).count, 3, "Did not find the correct number of records for today")
        
        //Place some records tomorrow, so that we can confirm that its not picking up extraneous data
        for i in 1...4{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.create(timestamp: obj.startDate.nextDayAt(hours: i, minutes: i))
        }
        XCTAssertEqual(obj.recordsFromDay(date: Date()).count, 3, "Found records for a different day")
        
        //Place some records without the activity sub element
        for _ in 1...2{
            let record = RecordObject()
            record.child = obj.appChild
            record.social = SocialObject()
            record.create()
        }
        XCTAssertEqual(obj.recordsFromDay(date: Date()).count, 3, "Found records without the activity element")
    }
    
    func testTimeIntervalCount(){
        let obj = setUpObject()
        
        //Make records between 3 and 4
        for i in 0...5{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.create(timestamp: obj.startDate.dateAt(hours: 3, minutes: i))
        }
        XCTAssertEqual(obj.timeIntervalCount(startHour: 3, endHour: 4, records: obj.recordsFromDay(date: obj.startDate)), 6.0, "Did not find correct number of records in the time interval")
        //Special case of a record right at the end of the interval (which should be ignored)
        let record = RecordObject()
        record.child = obj.appChild
        record.activity = ActivityObject()
        record.create(timestamp: obj.startDate.dateAt(hours: 4, minutes: 0))
        XCTAssertEqual(obj.timeIntervalCount(startHour: 3, endHour: 4, records: obj.recordsFromDay(date: obj.startDate)), 6.0, "Counted a record at the end of the interval")
        
        //Check for records outside the interval
        for i in 1...3{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.create(timestamp: obj.startDate.dateAt(hours: 6, minutes: i))
        }
        
        XCTAssertEqual(obj.timeIntervalCount(startHour: 3, endHour: 4, records: obj.recordsFromDay(date: obj.startDate)), 6.0, "Counted records outside of the interval")

    }
    
    func testDayData(){
        let obj = DayAnalysisQuery(appChild: AppChild(), startDate: Date(), element: "Activity")
        
        //Seed database
        for i in 1...5{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.activity?.excessivelyActive = 1
            record.activity?.abnormalRepMov = 2
            record.activity?.selfInjury = 1
            record.activity?.sluggish = 0
            record.activity?.screams = 2
            record.create(timestamp: obj.startDate.dateAt(hours: i, minutes: i))
        }
        
        //Test that there are 5 across board in the first time interval
        XCTAssertEqual(obj.dayData() as NSArray, [[5.0, 0.0, 0.0, 0.0], [5.0, 0.0, 0.0, 0.0], [5.0, 0.0, 0.0, 0.0], [5.0, 0.0, 0.0, 0.0], [5.0, 0.0, 0.0, 0.0]] as NSArray, "Incorrect counts found")
        
        for i in 6...10{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.activity?.excessivelyActive = 0
            record.create(timestamp: obj.startDate.dateAt(hours: i, minutes: i))
        }
        
        for i in 12...17{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.activity?.abnormalRepMov = 0
            record.create(timestamp: obj.startDate.dateAt(hours: i, minutes: i))
        }
        
        for i in 18...20{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.activity?.selfInjury = 0
            record.create(timestamp: obj.startDate.dateAt(hours: i, minutes: i))
        }
        
        //Test that they still have 5 in the first time interval, but now the first also has 5 in the second time interval, the second has 6 in the third interval, and the third also has 3 in the fourth interval
        XCTAssertEqual(obj.dayData() as NSArray, [[5.0, 5.0, 0.0, 0.0], [5.0, 0.0, 6.0, 0.0], [5.0, 0.0, 0.0, 3.0], [5.0, 0.0, 0.0, 0.0], [5.0, 0.0, 0.0, 0.0]] as NSArray, "Incorrect counts found")
        
    }
    
    //Verify the helper method for the week data calculation separately, so that it can be taken for granted in the following test
    func testSubElementCounts(){
        let obj = WeekAnalysisQuery(appChild: AppChild(), startDate: Date(), element: "Activity")
        
        //Seed 5 records on that day with all 5 subelements
        for i in 1...5{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.activity?.excessivelyActive = 1
            record.activity?.abnormalRepMov = 2
            record.activity?.selfInjury = 1
            record.activity?.sluggish = 0
            record.activity?.screams = 2
            record.create(timestamp: obj.startDate.dateAt(hours: i, minutes: i))
        }
        
        XCTAssertEqual(obj.subElementCounts(date: obj.startDate), Array(repeatElement(5.0, count: 5)), "Did not find the correct counts for each subElement")
        
    }
    
    func testWeekData(){
        //November 6, 2016 is a Sunday, use this date so that there is a known correct sequence of days
        var dateComponents = DateComponents()
        dateComponents.month = 11
        dateComponents.day = 6
        dateComponents.year = 2016
        let novSixth = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)?.date(from: dateComponents)
        
        let obj = WeekAnalysisQuery(appChild: AppChild(), startDate: novSixth!, element: "Activity")
        //Seed database for week with each day having one record for each sub element
        for i in 0...6{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.activity?.excessivelyActive = 1
            record.activity?.abnormalRepMov = 2
            record.activity?.selfInjury = 1
            record.activity?.sluggish = 0
            record.activity?.screams = 2
            record.create(timestamp: obj.startDate.previousDate(numberOfDays: i))
        }
        //Seed past two days with additional data
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.activity?.excessivelyActive = 1
            record.activity?.abnormalRepMov = 2
            record.activity?.selfInjury = 1
            record.activity?.sluggish = 0
            record.activity?.screams = 2
            record.create(timestamp: obj.startDate)
        
        //Generate the correct output manually
        var answer = [DayDataObject]()
        answer.append(DayDataObject(weekday: "Mon", subElementCounts: Array(repeating: 1.0, count: 5)))
        answer.append(DayDataObject(weekday: "Tues", subElementCounts: Array(repeating: 1.0, count: 5)))
        answer.append(DayDataObject(weekday: "Wed", subElementCounts: Array(repeating: 1.0, count: 5)))
        answer.append(DayDataObject(weekday: "Thurs", subElementCounts: Array(repeating: 1.0, count: 5)))
        answer.append(DayDataObject(weekday: "Fri", subElementCounts: Array(repeating: 1.0, count: 5)))
        answer.append(DayDataObject(weekday: "Sat", subElementCounts: Array(repeating: 1.0, count: 5)))
        answer.append(DayDataObject(weekday: "Sun", subElementCounts: Array(repeating: 2.0, count: 5)))
        
        let output = obj.weekData()
        
        XCTAssertEqual(output.count, answer.count, "Did not return 7 days of data")
        
        for (i, dayData) in answer.enumerated(){
            let check = output[i].equal(data: dayData)
            XCTAssertTrue(output[i].equal(data: dayData), "Day \(i+1) incorrect")
            //Additional detail on failure
            if (!check){
                XCTAssertEqual(output[i].weekday, dayData.weekday, "Day \(i+1) incorrect weekday")
                XCTAssertEqual(output[i].subElementCounts, dayData.subElementCounts, "Day \(i+1) incorrect subElementCounts")
            }
        }
    }
    
    func testMonthData(){
        //Testing based on November 6, 2016
        var dateComponents = DateComponents()
        dateComponents.month = 11
        dateComponents.day = 6
        dateComponents.year = 2016
        let novSixth = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)?.date(from: dateComponents)
        
        let obj = MonthAnalysisQuery(appChild: AppChild(), startDate: novSixth!, element: "Activity")
        
        //Seed Data for previous 28 days
        for i in 0...28{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.activity?.excessivelyActive = 1
            record.activity?.abnormalRepMov = 2
            record.activity?.selfInjury = 1
            record.activity?.sluggish = 0
            record.activity?.screams = 2
            record.create(timestamp: obj.startDate.previousDate(numberOfDays: i))
        }
        
        for i in 0...13{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.activity?.excessivelyActive = 1
            record.activity?.abnormalRepMov = 2
            record.activity?.selfInjury = 1
            record.activity?.sluggish = 0
            record.activity?.screams = 2
            record.create(timestamp: obj.startDate.previousDate(numberOfDays: i))
        }
        
        for i in 0...6{
            let record = RecordObject()
            record.child = obj.appChild
            record.activity = ActivityObject()
            record.activity?.excessivelyActive = 1
            record.activity?.abnormalRepMov = 2
            record.activity?.selfInjury = 1
            record.activity?.sluggish = 0
            record.activity?.screams = 2
            record.create(timestamp: obj.startDate.previousDate(numberOfDays: i))
        }
        
        //Generate answer
        let ansLabels = ["10/10", "10/17", "10/24", "10/31"]
        var ansValues = [[Double]]()
        ansValues.append(Array(repeating: 7.0, count: 5))
        ansValues.append(Array(repeating: 7.0, count: 5))
        ansValues.append(Array(repeating: 14.0, count: 5))
        ansValues.append(Array(repeating: 21.0, count: 5))
        
        let output = obj.monthData()
        let (labels, values) = WeekDataObject.combineArrays(weekData: output)
        
        XCTAssertEqual(ansLabels, labels, "Incorrect labels")
        
        for (i, val) in ansValues.enumerated(){
            XCTAssertEqual(values[i], val, "Incorrect values for week \(i)")
        }
        
        
    }

}
