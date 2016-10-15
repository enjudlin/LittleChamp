//
//  RealmObjects.swift
//  ChildWellnessApplication
//
//  Created by Chen Rong on 10/9/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

class AppUser: Object {
    
    // want to indexed email or add an id as a primary key for faster query
    // may also need to encrypt password
    dynamic var email: String? = nil
    dynamic var password: String? = nil
    dynamic var name: String? = nil
    let childList = LinkingObjects(fromType: AppChild.self, property: "parent")
    
    /*
    * Convert the childList relation to an array of Child objects
    */
    func children()->[Child]{
        var children = [Child]()
        for child in self.childList {
            children.append(child.toChild())
        }
        return children
    }
}

