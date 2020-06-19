//
//  TransactOnPredictionTest.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 6/18/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain
import Alamofire


extension TimeFountainTests {

    func testTransactOnPredictionTest() {
        let TransactOnPredictionTestExpectation = expectation(description: "TransactOnPredictionTest")
        URL.transactBased(
            on: BuyMarketStock.Prediction(
                direction: .goingUp,
                percentile: .lowerTen
            ),
            with: 10,
            for: "NDLS",
            marketValue: 99.0 // TODO get the estimated buy value from the quote
        ) { confirmation in
            TransactOnPredictionTestExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
