//
//  StreamerKeysTest.swift
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

    /// This is not necessary for streaming to function.  Streaming requires user principals.
    func testStreamerKeysTest() {
        let StreamerKeysTestExpectation = expectation(description: "StreamerKeysTest")
        URLRequest.streamerSubscriptionKeys().getData { data in
            let keys = StreamerSubscriptionKeys(data)
            XCTAssert(keys != nil)
            StreamerKeysTestExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
