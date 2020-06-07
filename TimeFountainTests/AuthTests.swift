//
//  AuthTests.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 6/5/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain

extension TimeFountainTests {
    
    func testRefreshToken() {
        let expectation = self.expectation(description: "token object")
        var toke: Token?
        URL.tokenRefresh { token in
            token.write()
            toke = token
            XCTAssert(false, "we got a response from the tokens.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(toke)
    }
    
    func testAuthToken() {
        let expectation = self.expectation(description: "token object")
        var toke: Token?
        URL.accessToken().getData { data in
            let token = Token(data)
            token?.write()
            toke = token
            XCTAssert(token != nil, "we got a response from the tokens.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(toke)
    }
    
}
