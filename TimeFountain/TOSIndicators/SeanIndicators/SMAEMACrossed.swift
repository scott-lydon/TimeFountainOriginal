//
//  SMAEMACrossed.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

typealias PriceMovementAfter = SMAEMACrossed


enum SMAEMACrossed: String {
    case upward, downward, no
    
    static func fromPrice(_ first: Double, _ second: Double) -> SMAEMACrossed {
        if first == second {
            return .no
        } else if first < second {
            return .upward
        } else {
            return .downward
        }
    }
}
