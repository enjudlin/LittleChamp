//
//  AppRecord.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 10/18/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation
import RealmSwift

class RecordObject: Object {
    dynamic var child: AppChild?
    dynamic var dateCreated = Date()
    dynamic var activity: ActivityObject?
    
    //Save record in Realm database
    func create(){
        let realm = try! Realm()
        //Writing in realm is automatically a transaction
        try! realm.write{
            //Save subrecords-- the if statements check that there is an object to save
            if let act = self.activity{
                realm.add(act)
            }
            self.dateCreated = Date()
            realm.add(self)
        }
    }
}
