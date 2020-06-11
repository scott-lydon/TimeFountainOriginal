//
//  GetOrderTest.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 6/8/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain

extension TimeFountainTests {

    func testGetOrder() {
        let expectation = self.expectation(description: "token object")
        let orderID = "1148576287"
        URL.get(order: orderID) { confirmation in
            print("we have a confirmation: ", confirmation)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
