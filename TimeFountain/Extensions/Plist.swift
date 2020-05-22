//
//  Plist.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    static var plist: Dictionary<String, Any> {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
           nsDictionary = NSDictionary(contentsOfFile: path)
        }
        return nsDictionary as? Dictionary<String, Any> ?? [:]
    }
}
