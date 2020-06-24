//
//  emaTests.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 6/19/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain


fileprivate struct EmaInOuts {
    var prices: [Double]
    var range: Int
    var smoothing: Int
    var resultingEMA: [Double?]
}

// Takes an array of tick values (price, close, high, open)
//  price: CLOSE
//  length: 180
fileprivate var inputOutputs: [EmaInOuts] = [
    EmaInOuts(
        prices: [1, 1, 1, 1],
        range: 4,
        smoothing: 2,
        resultingEMA: [nil, nil, nil, 1]
    ),
    EmaInOuts(
        prices: [1, 2, 5, 3],
        range: 4,
        smoothing: 2,
        resultingEMA: [nil, nil, nil, (1 + 2 + 5 + 3) / 4]
    ),
    EmaInOuts(
        prices: [1, 2, 5, 3],
        range: 3,
        smoothing: 2,
        resultingEMA: [
            nil,
            nil,
            (1 + 2 + 5) / 3,
            lastItem,
        ]
    ),
]

let lastItem: Double = 3 * (Double(2) / (Double(3) + 1)) + (1 + 2 + 5) / 3 * (1 - (Double(2) / (Double(3) + 1)))
///2.833333333333333

extension TimeFountainTests {
    
    func testema() {
        print("lastItem: ", lastItem)
        inputOutputs.forEach {
            let test = $0.prices.emas(for: $0.range)
            let correct = $0.resultingEMA
            XCTAssert(test == correct, "Failed when test: \(test) was not \(correct)")
        }
    }
}

