//
//  FinvizTest.swift
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

    func testFinvizTest() {
        let FinvizTestExpectation = expectation(description: "FinvizTest")
        URL.finviz { symbols in
            FinvizTestExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
