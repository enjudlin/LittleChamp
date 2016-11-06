//
//  SocialObject.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/22/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

class SocialObject: Object, RecordElement {
    
    /* 3 is the default and indicates that the field was not selected at all. 0, 1, and 2 refer to mile, moderate, and severe selections.*/
    dynamic var argue = 3
    dynamic var defiant = 3
    dynamic var withdrawn = 3
    dynamic var resistContact = 3
    dynamic var harmOthers = 3
    
    /* Description strings for each of the categories */
    dynamic var argueDesc = ""
    dynamic var defiantDesc = ""
    dynamic var withdrawnDesc = ""
    dynamic var resistContactDesc = ""
    dynamic var harmOthersDesc = ""
    
    static var subElementStrings = ["argue", "defiant", "withdrawn", "resistContact", "harmOthers"]
}
