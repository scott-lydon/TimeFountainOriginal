//
//  SImpleRSIIndicator.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

enum SimpleRSIPercentile {
    case low, mid, top
    
    init(rsi: Double) {
        if rsi < 0.3 {
            self = .low
        } else if rsi > 0.6 {
            self = .top
        } else {
            self = .mid
        }
    }
}


extension Array where Element == Double {
    
    func simpleRisIndicators(length: Int) -> [SimpleRSIPercentile?] {
        rsis(length: length).map {
            guard let rsi = $0 else { return nil }
            return SimpleRSIPercentile(rsi: rsi)
        }
    }
    
}
