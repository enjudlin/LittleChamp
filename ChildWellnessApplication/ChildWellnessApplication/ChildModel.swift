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

class Child {
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
    
    class func getChildren() -> [Child]{
        let realm = try! Realm()
        var children = [Child]()
        let childObjects = realm.objects(AppChild.self)
        for childObject in childObjects{
            children.append(childObject.toChild())
        }
        return children
    }
    
}
