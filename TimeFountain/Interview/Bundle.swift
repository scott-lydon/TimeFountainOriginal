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
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    static var appName: String? {
        Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
//    static func thisApp: Bundle {
//        return Bundle(for: AppDelegate.self)
//    }
    
    static var version: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static var tdAccount_id: String? {
        plist?[accountidKey] as? String
    }
    
    static var td_api_key: String? {
        return plist?[apikeyKey] as? String
    }
    
    static var td_AccessToken: String {
        String.accessTokenLiteral.localized(fileName: "Credentials")
    }
    
    static var plist: [String: Any]? {
        print("plist: --> ", #line)
        guard let fileUrl = Bundle.main.url(
            forResource: "Info",
            withExtension: "plist"
            ) else { return nil }
        print("File url: --> ", fileUrl)
        do {
            let data = try Data.init(contentsOf: fileUrl)
            let plist = try! PropertyListSerialization.propertyList(from:data, options: [], format: nil) as! [String:Any]
            return plist
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
    
    static func getPath() -> String {
        let plistFileName = "Info.plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = paths[0] as NSString
        let plistPath = documentPath.appendingPathComponent(plistFileName)
        return plistPath
    }
}
