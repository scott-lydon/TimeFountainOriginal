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
        let url = URL.priceHistory(
            period: .days(.ten, .oneMinute),
            ticker: ticker
        )
        url.getData { data in
            guard let candleList = CandleList(data) else {
                XCTAssert(false)
                return
            }
            guard let dataframe = DataFrame(candleList) else {
                XCTAssert(false)
                return
            }
            XCTAssert(true)
            let _ = dataframe.save(ticker: "test")
            /// TODO test how to save.
            
            GetHistoryTestExpectation.fulfill()
        }
        print(url)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
