//
//  RecordElementProtocol.swift
//  ChildWellnessApplication
//
//  Created by Katie Jackson on 11/4/16.
//  Copyright © 2016 group6. All rights reserved.
//

import Foundation

/*A protocol in Swift is similar to an interface in Java. This protocol is to ensure that all Realm objects that are a subelement of Record have the properties expected by queries in the DataAnalysisQuery classes*/
protocol RecordElement {
    static var subElementStrings: [String] {get}
}
