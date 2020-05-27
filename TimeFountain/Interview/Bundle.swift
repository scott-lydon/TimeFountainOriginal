//
//  Bundle.swift
//  ScottLydon
//
//  Created by Scott Lydon on 10/2/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//

import Foundation

public extension Bundle {
    
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    static var appName: String? {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
//    static func thisApp: Bundle {
//        return Bundle(for: AppDelegate.self)
//    }
    
    static var version: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static var tdAccount_id: String? {
        return plist?["ACCOUNT_ID"] as? String
    }
    
    static var td_api_key: String? {
        return plist?["TDAMERITRADE_API_KEY"] as? String
    }
    
    static var plist: [String: Any]? {
        guard let fileUrl = Bundle.main.url(
            forResource: "Info",
            withExtension: "plist"
            ) else { return nil }
        do {
            let data = try Data.init(contentsOf: fileUrl)
            let plist = try! PropertyListSerialization.propertyList(from:data, options: [], format: nil) as! [String:Any]
            return plist
        } catch {
            return nil
        }
    }
}
