//
//  Double.swift
//  ScottLydon
//
//  Created by Scott Lydon on 10/2/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//

import Foundation


public typealias DoubleAction = (Double) -> Void

public extension Double {
    
    var string: String {
        return String(self)
    }
    
    func isBetween(_ first: Double, _ second: Double) -> Bool {
        first <= self && self <= second
    }
}



