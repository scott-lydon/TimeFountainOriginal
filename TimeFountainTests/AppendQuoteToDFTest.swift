//
//  AppendQuoteToDFTest.swift
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

    func testAppendQuoteToDFTest() {
        let AppendQuoteToDFTestExpectation = expectation(description: "AppendQuoteToDFTest")
        let ticker = "TSLA"
        URL.priceHistories(ticker: ticker) { dataFrame in
            guard let dataFrame = dataFrame else { return }
            URL.streamQuotes(for: ticker) { quote in
                let lastRow = dataFrame.lastRow
                dataFrame.append(quote)
                XCTAssertNotEqual(lastRow, dataFrame.lastRow)
                let value: String = (dataFrame.lastRow["close"] ?? "nil") ?? "nil"
                XCTAssertEqual(Double(value), quote.data.first?.content.first?.the15)
                AppendQuoteToDFTestExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
