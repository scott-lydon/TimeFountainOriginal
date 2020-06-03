//
//  StringAny.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/1/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    var asJSON: String? {
        guard let jsonData = try? JSONSerialization.data(
            withJSONObject: self,
            options: []
            ) else { return nil }
        return String(data: jsonData, encoding: .ascii)
    }
}

/*
 
 let dictionary = ["aKey": "aValue", "anotherKey": "anotherValue"]
if let theJSONData = try? JSONSerialization.data(
    withJSONObject: dictionary,
    options: []) {
    let theJSONText = String(data: theJSONData,
                               encoding: .ascii)
    print("JSON string = \(theJSONText!)")
}
 */
