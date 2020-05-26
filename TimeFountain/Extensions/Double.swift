//
//  Double.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/25/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Double {
    func isBetween(_ first: Double, _ second: Double) -> Bool {
        first <= self && self <= second
    }
}
