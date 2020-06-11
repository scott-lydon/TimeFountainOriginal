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
                XCTAssert(false, response.content.msg + "Troubleshooting, 1. double check that types match (number string, bool), \n2. Double check the refresh token is refreshed prior.  Make sure it works with other calls. \n3. Make sure the JSON is serialized correctly.  \n4 make sure parameter names match.")
            }
            streamed.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGeneralLogin() {
        let heartBeatExpectation = expectation(description: "heartBeat")
        URL.stream(
            []
        ) { message in
            print(message)
            guard let data = message.data(using: .utf8) else { return }
            if let heartBeat = HeartBeat(data) {
                print("Yay, we are winning, we have a heartbeat: \(heartBeat)")
                heartBeatExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
}



