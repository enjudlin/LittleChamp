//
//  ChildModel.swift
//  ChildWellnessApplication
//
//  Created by kampen, samuel scott on 9/27/16.
//  Copyright (c) 2016 group6. All rights reserved.
//

import Foundation
import UIKit

class Child {
    // MARK: Properties
    var name: String
    var gender: String
    var age: Int
    var birthDate: String
    var fullAgeString: String
    
    // Mark: Initialization
    
    //Initialization method for a Child Object
    //
    //Requires: name is a String containing the childs name
    //          gender is the string "male" or "female"
    //          birthDate is a String containing the childs birthdate of the form
    //          yyyy-MM-dd Example: 1989-11-23
    //
    //Ensures: The object returned is a Child object
    init?(name: String, gender: String, birthDate: String){
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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthdayDateObj = dateFormatter.date(from: birthDate)
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.unitsStyle = DateComponentsFormatter.UnitsStyle.full
        let interval = NSDate().timeIntervalSince(birthdayDateObj!)
        let ageString = dateComponentsFormatter.string(from: interval)
        self.fullAgeString = ageString!
        let delimiter = " "
        var token = ageString!.components(separatedBy: delimiter)
        let ageScale = token[1]
        self.age = Int(token[0])!
        if(ageScale != "years,"){
            self.age = 0
        }
    }
}
