//
//  Int.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/16/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension DispatchGroup {
    func enter(_ int: Int) {
        for num in 1...int {
            self.enter()
            print(String(num) + "enter")
        }
    }
}
