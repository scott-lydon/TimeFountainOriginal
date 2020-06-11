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
        URL.refreshToken { token in
            toke = token
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(toke)
    }
    
    func testRefreshTokenReplaceKeychain() {
        let expectation = self.expectation(description: "token object")
        var toke: Token?
        let initialRefresh = Keychain.loadFrom(key: .refreshTokenKey)
        let initialAccess = Keychain.loadFrom(key: .accessTokenKey)
        URL.refreshToken { token in
            toke = token
            let resultRefresh = Keychain.loadFrom(key: .refreshTokenKey)
            let resultAccess = Keychain.loadFrom(key: .accessTokenKey)
            XCTAssert(initialRefresh != resultRefresh, "Failed to replace refresh")
            XCTAssert(initialAccess != resultAccess, "Failed to replace access")
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
