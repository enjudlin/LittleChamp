//
//  CommunicationObject.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/22/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

class CommunicationObject: Object {
    
    /* -1 is the default and indicates that the field was not selected at all. This should never happen because the UI automatically selects 3 (N/A) until the user chooses one of the other options. 0, 1, and 2 refer to mile, moderate, and severe selections.*/
    dynamic var unresponsive = -1
    dynamic var excessiveTalk = -1
    dynamic var noCommunication = -1
    dynamic var talkToSelf = -1
    dynamic var difficultyExpressing = -1
    
    /* Description strings for each of the categories */
    dynamic var unresponsiveDesc = ""
    dynamic var excessiveTalkDesc = ""
    dynamic var noCommunicationDesc = ""
    dynamic var talkToSelfDesc = ""
    dynamic var difficultyExpressingDesc = ""

}
