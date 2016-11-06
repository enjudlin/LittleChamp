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
}
