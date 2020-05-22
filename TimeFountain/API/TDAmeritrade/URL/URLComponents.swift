//
//  Components.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import ScottLydon

class TDAmeritradeURL {
    
    @discardableResult
    func kv(_ key: TDAmeritradeURL.Key, _ value: String?) -> TDAmeritradeURL {
        guard let value = value else { return self }
        str.append(String(key: key.rawValue, value))
        return self
    }
    
    @discardableResult
    func kv(_ dict: [TDAmeritradeURL.Key: String?]) -> TDAmeritradeURL {
        for (key, value) in dict {
            guard let value = value else { continue }
            str.append(String(key: key.rawValue, value))
        }
        return self
    }
    
    func apiKey(_ apiKey: String?) -> TDAmeritradeURL {
        if apiKey == "" || apiKey == nil {
            print("ERROR: API KEY WAS NOT SET PROPERLY")
        }
        return kv(.apikey, apiKey)
    }
    
    func period(_ period: URL.Period) -> TDAmeritradeURL {
        return kv(period.dictionary)
    }
    
    func endDate(_ endDate: Date?) -> TDAmeritradeURL {
        return kv(.endDate, endDate?.timeIntervalSince1970.string)
    }
    
    func startDate(_ startDate: Date?) -> TDAmeritradeURL {
        return kv(.startDate, startDate?.timeIntervalSince1970.string)
    }
    
    func needsExtendedHoursData(_ needsExtendedHoursData: Bool?) -> TDAmeritradeURL {
        return kv(.needsExtendedHoursData, needsExtendedHoursData?.string)
    }
//    func row(_ value: Int) -> TDAmeritradeURL {
//        return kv(.row, String(value))
//    }
//
//    func submit(_ value: Bool) -> TDAmeritradeURL {
//        return kv(.submit, String(value))
//    }
    
    var str = ""
    init(path: String) {
        str.append(UserDefaults.baseUrlToUse + path + "?")
    }
    
    var build: URL {
        str.removeLast()
        return URL(string: str)!
    }
}
