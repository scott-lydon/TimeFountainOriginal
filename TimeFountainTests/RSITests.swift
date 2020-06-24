//
//  RSITests.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 6/20/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//


import Foundation
import XCTest
@testable import TimeFountain


fileprivate struct RSIInOuts {
    var prices: [Double]
    var length: Int
    var resultingRSI: [Double?]
}

fileprivate var inputOutputs: [RSIInOuts] = [
    RSIInOuts(
        prices: [9, 3, 4, 5, 6, 23, 5, 6, 7, 4, 6, 46, 2],
        length: 3,
        resultingRSI: [nil, nil, nil, 1]
    ),
]


extension TimeFountainTests {
    
    func testRSI() {
        print("lastItem: ", lastItem)
        inputOutputs.forEach {
            let test = $0.prices.rsis()
            let correct = $0.resultingRSI
            XCTAssert(test == correct, "Failed when test: \(test) was not \(correct)")
        }
    }
}


