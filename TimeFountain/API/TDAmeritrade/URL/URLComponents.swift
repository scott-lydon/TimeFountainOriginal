//
//  Components.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

let apikeyKey = "TDAMERITRADE_API_KEY"
let accountidKey = "ACCOUNT_ID"

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
    
    func apiKey(_ apiKey: String? = Bundle.td_api_key) -> TDAmeritradeURL {
        if apiKey == "" || apiKey == nil {
            print("ERROR: API KEY WAS NOT SET PROPERLY, please visit: https://medium.com/p/6ce316a5887/edit to get your account id and api key.  Set the them as values for \(apikeyKey) key and \(accountidKey)" )
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
        str.append(String.baseURL + path + "?")
    }
    
    init(authPath: String) {
        str.append(String.authURL + authPath + "?")
    }
    
    convenience init(authPath: Path) {
        self.init(authPath: authPath.rawValue)
    }
    
    convenience init(path: Path) {
        self.init(path: path.rawValue)
    }
    
    convenience init(paths: [Path]) {
        self.init(path: .slashes(paths.map({ $0.rawValue})))
    }
    
    convenience init(paths: Path...) {
        self.init(path: .slashes(paths.map({ $0.rawValue})))
    }
    
    var build: URL {
        str.removeLast()
        return URL(string: str)!
    }
}
