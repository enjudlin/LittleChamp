//
//  UserModel.swift
//  ChildWellnessApplication
//
//  Created by Chen Rong on 10/3/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit
import Foundation

class UserModel: NSObject {
    
    // MARK: properties
    var email: String
    var password: String
    var name: String
    var childrenList = [ChildModel]()
    
    // MARK: initialization
    init?(email:String, password:String, name:String) {
        
        if email.isEmpty {
            return nil
        } else {
            self.email = email
        }
        
        if password.isEmpty {
            return nil
        } else {
            self.password = password
        }
        
        if name.isEmpty {
            return nil
        } else {
            self.name = name
        }
    }
    

}
