//
//  Bundle.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Bundle {
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
