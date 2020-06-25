//
//  Array+ManualLine.Indicator.Percent.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/24/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


extension Array where Element == ManualLine.Indicator {
    /// Used to create a relative comparitive scale for teh candles being analyzed.  Creating a baseline of comparison.
    enum Percent: String {
        case toTen, toTwenty, toThirty, toForty, toFifty, toSixty, toSeventy, toEighty, toNinety, to100
    
        init(score: Double, min: Double, max: Double) {
            let increment = abs(max - min) / 10
            if min...(min + increment) ~= score   {
                self = .toTen
            } else if (min + increment)...(min + increment * 2) ~= score   {
                self = .toTwenty
            } else if (min + increment * 2)...(min + increment * 3) ~= score {
                self = .toThirty
            } else if  (min + increment * 3)...(min + increment * 4) ~= score {
                self = .toForty
            } else if  (min + increment * 4)...(min + increment * 5) ~= score {
                self = .toFifty
            } else if  (min + increment * 5)...(min + increment * 6) ~= score {
                self = .toSixty
            } else if (min + increment * 6)...(min + increment * 7) ~= score {
                self = .toSeventy
            } else if  (min + increment * 7)...(min + increment * 8) ~= score {
                self = .toEighty
            } else if  (min + increment * 8)...(min + increment * 9) ~= score {
                self = .toNinety
            } else if  (min + increment * 9)...(min + increment * 10) ~= score {
                self = .to100
            } else {
                print("ERROR: Should not reach: \(#line)")
                self = .to100
            }
        }
    }
    
    enum SimplePercent: String {
        case toTwenty,  toForty, toSixty, toEighty, to100
        
         init(score: Double, min: Double, max: Double) {
            let increment = abs(max - min) / 10
            if  min...(min + increment * 2) ~= score {
                self = .toTwenty
            } else if (min + increment * 2)...(min + increment * 4) ~= score {
                self = .toForty
            } else if (min + increment * 4)...(min + increment * 6) ~= score {
                self = .toSixty
            } else if (min + increment * 5)...(min + increment * 8) ~= score {
                self = .toEighty
            } else if (min + increment * 8)...(min + increment * 10) ~= score {
                self = .to100
            } else {
                print("ERROR: Should not reach: \(#line)")
                self = .to100
            }
        }
    }
}
