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
    
    /*Access the analysis factory to get the analysis information*/
    private var analysisFactory: AnalysisLogicFactory?
    
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
        calcAge(today: Date())
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
        calcAge(today: Date())
    }
    
    //Use the singleton pattern to get the analysis factory
    func analysisLogic()->AnalysisLogicFactory{
        if (self.analysisFactory == nil){
            self.analysisFactory = AnalysisLogicFactory(appChild: self.appChild!)
        }
        return self.analysisFactory!
    }
    
    //Calculate the child's age based on the birthdate of the child
    //By passing in today, this function is unit testable because one can set fixed dates when testing
    func calcAge(today: Date){        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        self.age = (calendar?.components(NSCalendar.Unit.year, from: self.birthDate, to: today).year)!
    }
    
    //Create the child and save it in the Realm database
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
        self.appChild = appChild
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
    
}
