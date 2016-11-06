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
    dynamic var emotion: EmotionObject?
    dynamic var communication: CommunicationObject?
    dynamic var social: SocialObject?
    
    //Helper to save sub element records -- MUST BE CALLED IN A REALM WRITE TRANSACTION
    func saveSubRecords(realm: Realm){
        //Save subrecords-- the if statements check that there is an object to save
        if let act = self.activity{
            realm.add(act)
        }
        if let em = self.emotion{
            realm.add(em)
        }
        if let com = self.communication{
            realm.add(com)
        }
        if let soc = self.social{
            realm.add(soc)
        }
    }
    
    //Save record in Realm database
    func create(){
        let realm = try! Realm()
        //Writing in realm is automatically a transaction
        try! realm.write{
            
            saveSubRecords(realm: realm)
            
            //Set timestamp
            self.dateCreated = Date()
            realm.add(self)
        }
    }
    
    //Alternate implementation to save with a timestamp other than right now
    
    func create(timestamp: Date){
        let realm = try! Realm()
        //Writing in realm is automatically a transaction
        try! realm.write{
            
            saveSubRecords(realm: realm)
            
            //Set timestamp
            self.dateCreated = timestamp
            realm.add(self)
        }
    }
    
}
