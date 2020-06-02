//
//  String.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension String {
    
    fileprivate static var plist: Dictionary<String, Any> {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
           nsDictionary = NSDictionary(contentsOfFile: path)
        }
        return nsDictionary as? Dictionary<String, Any> ?? [:]
    }
    
    static var account_id: String? {
        return plist["ACCOUNT_ID"] as? String
    }
    
    static var tdAmeritradeKey: String? {
        return plist["TDAMERITRADE_API_KEY"] as? String
    }
    
    static var marketData: String {
        return "marketdata"
    }
    
    static var priceHistory: String {
        return "pricehistory"
    }
    
    static func slashes(_ folders: String...) -> String {
        return folders.joined(separator: "/")
    }
    
    static func slashes(_ folders: [String]) -> String {
        folders.joined(separator: "/")
    }
    
    var tdDate: Date? {
        let df = DateFormatter()
        df.dateFormat = .tdAmeritradeFormat
        df.timeZone = TimeZone(identifier: "GMT")
        return df.date(from: self)
    }
}
