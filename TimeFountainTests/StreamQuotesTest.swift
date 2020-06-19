//
//  StreamQuotesTest.swift
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

    func testStreamQuotesTest() {
        let StreamQuotesTestExpectation = expectation(description: "StreamQuotesTest")
        let ticker = "TSLA"
        URL.streamQuotes(for: ticker) { quote in
            StreamQuotesTestExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
