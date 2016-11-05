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
    
    /* -1 is the default and indicates that the field was not selected at all. This should never happen because the UI automatically selects 3 (N/A) until the user chooses one of the other options. 0, 1, and 2 refer to mile, moderate, and severe selections.*/
    dynamic var argue = -1
    dynamic var defiant = -1
    dynamic var withdrawn = -1
    dynamic var resistContact = -1
    dynamic var harmOthers = -1
    
    /* Description strings for each of the categories */
    dynamic var argueDesc = ""
    dynamic var defiantDesc = ""
    dynamic var withdrawnDesc = ""
    dynamic var resistContactDesc = ""
    dynamic var harmOthersDesc = ""
    
    static var subElementStrings = ["argue", "defiant", "withdrawn", "resistContact", "harmOthers"]
}
