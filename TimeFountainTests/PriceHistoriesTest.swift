//
//  PriceHistoriesTest.swift
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

    func testPriceHistoriesTest() {
        let PriceHistoriesTestExpectation = expectation(description: "PriceHistoriesTest")
        let urls = URL.priceHistories(
            period: .days(.ten, .oneMinute),
            ticker: "TSLA"
        ) { dataFrame in
            //var dataFrame = dataFrame
            
            PriceHistoriesTestExpectation.fulfill()
        }
        XCTAssert(urls.count > 0)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
