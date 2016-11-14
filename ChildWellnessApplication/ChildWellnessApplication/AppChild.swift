//
//  AppChild.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/9/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

class AppChild: Object {
    
    dynamic var name = ""
    dynamic var gender = ""
    dynamic var birthdate = Date()
    dynamic var parent: AppUser?
    
    let records = LinkingObjects(fromType: RecordObject.self, property: "child")
    
    //Convert an AppChild object to a Child object.
    //Child is a wrapper for app child, and contains code to create and edit children as well as calculate age and convert time stamps to a string for the UI.
    func toChild()-> Child{
        return Child(appChild: self)
    }
}
