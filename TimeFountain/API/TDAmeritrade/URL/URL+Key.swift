//
//  URL+Key.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension TDAmeritradeURL {
    
    enum Key: String {
        case apikey
        case periodType
        case period
        case frequencyType
        case frequency
        case endDate
        case startDate
        case needsExtendedHoursData
        
        
//        case access_token
//        case allowsCourtesyCalls
//        case alwaysInUse
//        case assert
        
        func string(from value: String) -> String {
            return "\(rawValue.scaped ?? "")=\(value.scaped ?? "")&"
        }
    }
    

    
}
