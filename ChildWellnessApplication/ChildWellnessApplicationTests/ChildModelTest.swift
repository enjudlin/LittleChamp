//
//  ChildModelTest.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 11/13/16.
//  Copyright © 2016 group6. All rights reserved.
//

import XCTest
@testable import ChildWellnessApplication

class ChildModelTest: XCTestCase {
    
    //Helper function to generate a Date object using string input in the format mm/dd/yyyy
    private func generateDate(dateString: String)->Date{
        let dateformatter = DateFormatter()
        dateformatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) as Calendar!
        dateformatter.dateFormat = "MM/dd/yyyy"
        return dateformatter.date(from: dateString)!
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalcAge() {
        let child = Child(name: "name", gender: "male", birthDate: generateDate(dateString: "11/13/2010"), parent: AppUser())
        //Regular case: Test for a one year old
        child?.calcAge(today: generateDate(dateString: "11/15/2011"))
        XCTAssertEqual(child?.age, 1, "Did not identify one year old")
        
        //Edge case: Fifth birthday
        child?.calcAge(today: generateDate(dateString: "11/13/2015"))
        XCTAssertEqual(child?.age, 5, "Did not identify five year old")
        
        //Edge case: Less than 1
        child?.calcAge(today: generateDate(dateString: "12/13/2010"))
        XCTAssertEqual(child?.age, 0, "Did not identify child under 1")
        
        //Weird (but possible) case of negative age
        child?.calcAge(today: generateDate(dateString: "11/12/2008"))
        XCTAssertEqual(child?.age, -2)
        
        //Very old
        child?.calcAge(today: generateDate(dateString: "12/25/2110"))
        XCTAssertEqual(child?.age, 100)
    }
    
}
