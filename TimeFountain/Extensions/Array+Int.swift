//
//  Array+Int.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    var allEqual: Bool {
        guard count >= 2, let first = first else { return true }
        return allSatisfy { $0 == first }
    }
}
