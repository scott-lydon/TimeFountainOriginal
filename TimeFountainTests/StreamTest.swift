//
//  StreamTest.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 6/10/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain
import Alamofire

extension TimeFountainTests {

    /// You need to comment out the other streams in hte project..Callbacks don't seem to work here if there is a parallel stream going in the project for some reason.
    func testOther() {
        let streamed = expectation(description: "streamed a response")
        URL.stream(
            [.quotes(
                QuoteParams([.CBLI], fields: .Symbol, .Close_Price)
                )
            ]
        ) { message in
            guard let data = message.data(using: .utf8) else { return }
            if let error = ErrorResponses(data),
                let response = error.response.first {
                
                XCTAssert(response.content.code != 21, "Login failed, Check that types are correct, for example, 30 should maybe be a string instead.")
                XCTAssert(false, response.content.msg)
            }
            streamed.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}



