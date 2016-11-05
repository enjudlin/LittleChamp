//
//  ActivityObject.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/18/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

class ActivityObject: Object, RecordElement{
    /* 3 is the default and indicates that the field was not selected at all (set to N/A in the UI). 0, 1, and 2 refer to mild, moderate, and severe selections.*/
    dynamic var excessivelyActive = 3
    dynamic var abnormalRepMov = 3
    dynamic var selfInjury = 3
    dynamic var sluggish = 3
    dynamic var screams = 3
    
    /* Description strings for each of the activities */
    dynamic var excessivelyActiveDesc = ""
    dynamic var abnormalRepMovDesc = ""
    dynamic var selfInjuryDesc = ""
    dynamic var sluggishDesc = ""
    dynamic var screamsDesc = ""
    
    static var subElementStrings = ["excessivelyActive", "abnormalRepMovement", "selfInjury", "sluggish", "screams"]
}
