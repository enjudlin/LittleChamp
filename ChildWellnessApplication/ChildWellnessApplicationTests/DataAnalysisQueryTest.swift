//
//  DataAnalysisQueryTest.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 11/5/16.
//  Copyright © 2016 group6. All rights reserved.
//

import XCTest
@testable import ChildWellnessApplication

class DataAnalysisQueryTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
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
}
