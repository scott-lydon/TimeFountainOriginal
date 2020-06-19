//
//  AccountTest.swift
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

    func testAccountTest() {
        let AccountTestExpectation = expectation(description: "AccountTest")
        URLRequest.account() { account in
            AccountTestExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
