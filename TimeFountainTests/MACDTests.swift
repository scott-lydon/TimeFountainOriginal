//
//  MACDTests.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 6/19/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain


fileprivate struct MACDInOuts {
    var prices: [Double]
    var fast: Int
    var slow: Int
    var length: Int
    var smoothing: Int
    var resultingMACD: [Double?]
}

fileprivate var inputOutputs: [MACDInOuts] = [
    MACDInOuts(
        prices: [1, 1, 1, 1],
        fast: 12,
        slow: 26,
        length: 9,
        smoothing: 2,
        resultingMACD: [nil, nil, nil, 1]
    ),
]


extension TimeFountainTests {
    
    func testMACD() {
        print("lastItem: ", lastItem)
        inputOutputs.forEach {
            let test = $0.prices.macdDiffs()
            let correct = $0.resultingMACD
            XCTAssert(test == correct, "Failed when test: \(test) was not \(correct)")
        }
    }
}


