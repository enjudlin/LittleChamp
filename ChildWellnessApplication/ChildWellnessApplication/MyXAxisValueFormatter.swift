//
//  MyXAxisValueFormatter.swift
//  ChildWellnessApplication
//
//  Created by Guest User on 11/2/16.
//  Copyright © 2016 group6. All rights reserved.
//

import UIKit
import Foundation
import Charts

public class MyXAxisFormatter: NSObject, IAxisValueFormatter{
    var labels: [String]?
    
    
    init(label: [String]){
        self.labels = label
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels![Int(value)]
    }
}

