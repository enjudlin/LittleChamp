//
//  AppRecord.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/18/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

class AppRecord: Object {
    dynamic var child: AppChild?
    dynamic var dateCreated = Date()
    dynamic var activity: ActivityObject?
}
