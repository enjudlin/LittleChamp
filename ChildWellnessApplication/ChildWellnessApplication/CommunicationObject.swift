//
//  CommunicationObject.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/22/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

//This is a sub element of the RecordObject class
class CommunicationObject: Object, RecordElement {
    
    /* 3 is the default and indicates that the field was not selected at all. 0, 1, and 2 refer to mile, moderate, and severe selections.*/
    dynamic var unresponsive = 3
    dynamic var excessiveTalk = 3
    dynamic var noCommunication = 3
    dynamic var talkToSelf = 3
    dynamic var difficultyExpressing = 3
    
    /* Description strings for each of the categories */
    dynamic var unresponsiveDesc = ""
    dynamic var excessiveTalkDesc = ""
    dynamic var noCommunicationDesc = ""
    dynamic var talkToSelfDesc = ""
    dynamic var difficultyExpressingDesc = ""
    
    static var subElementStrings = ["unresponsive", "excessiveTalk", "noCommunication", "talkToSelf", "difficultyExpressing"]
}
