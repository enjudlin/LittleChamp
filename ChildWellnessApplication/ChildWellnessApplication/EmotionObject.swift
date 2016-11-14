//
//  EmotionObject.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/22/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

//This is a sub element of the RecordObject class
class EmotionObject: Object, RecordElement {
    /* 3 is the default and indicates that the field was not selected at all. 0, 1, and 2 refer to mile, moderate, and severe selections.*/
    dynamic var tantrum = 3
    dynamic var depressed = 3
    dynamic var emResponse = 3
    dynamic var crying = 3
    dynamic var moodChanges = 3
    
    /* Description strings for each of the activities */
    dynamic var tantrumDesc = ""
    dynamic var depressedDesc = ""
    dynamic var emResponseDesc = ""
    dynamic var cryingDesc = ""
    dynamic var moodChangesDesc = ""
    
    static var subElementStrings = ["tantrum", "depressed", "emResponse", "crying", "moodChanges"]
}
