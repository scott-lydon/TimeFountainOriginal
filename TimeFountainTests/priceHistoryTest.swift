//
//  GetHistoryTest.swift
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
    
    func testGetHistoryTest() {
        let GetHistoryTestExpectation = expectation(description: "GetHistoryTest")
        let ticker = "TSLA"
        URL.priceHistory(
            period: .days(.ten, .oneMinute),
            ticker: ticker
        ).getData { data in
            guard let candleList = CandleList(data) else {
                XCTAssert(false)
                return
            }
            guard let dataframe = DataFrame(candleList) else {
                XCTAssert(false)
                return
            }
            XCTAssert(true)
            guard let _ = dataframe.convertToCSV(named: ticker + "test") else {
                XCTAssert(false)
                return
            }
            GetHistoryTestExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
