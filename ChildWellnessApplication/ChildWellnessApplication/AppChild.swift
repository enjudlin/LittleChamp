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
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    func toChild()-> Child{
        return Child(name: self.name, gender: self.gender, birthDate: self.birthdate)!
    }
}
