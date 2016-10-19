//
//  ActivityObject.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/18/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

class ActivityObject: Object {
    /* -1 is the default and indicates that the field was not selected. 0, 1, and 2 refer to mile, moderate, and severe selections.*/
    dynamic var excessivelyActive = -1
    dynamic var abnormalRepMov = -1
    dynamic var selfInjury = -1
    dynamic var sluggish = -1
    dynamic var screams = -1
    
    /* Description strings for each of the activities */
    dynamic var excessivelyActiveDesc = ""
    dynamic var abnormalRepMovDec = ""
    dynamic var selfInjuryDesc = ""
    dynamic var sluggishDesc = ""
    dynamic var screamsDesc = ""
}