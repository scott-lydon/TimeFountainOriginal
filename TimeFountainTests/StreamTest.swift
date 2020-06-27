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
    func testQuotes() {
        let streamed = expectation(description: "streamed a response")
        URL.stream(
            [.quotes(
                QuoteParams(["CBLI"], .Symbol, .Close_Price)
                )
            ]
        ) { message in
            guard let data = message.data(using: .utf8) else { return }
            if let _ = StreamedQuote(data) {
                streamed.fulfill()
            } else if let response = Response(data) {
                print(response.response.first?.content.msg ?? "nil response in list")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// You need to comment out the other streams in hte project..Callbacks don't seem to work here if there is a parallel stream going in the project for some reason.
    func testGeneralLogin() {
        let heartBeatExpectation = expectation(description: "heartBeat")
        URL.stream() { message in
            print(message)
            guard let data = message.data(using: .utf8) else { return }
            if let heartBeat = HeartBeat(data) {
                print("Yay, we are winning, we have a heartbeat: \(heartBeat)")
                heartBeatExpectation.fulfill()
            } else if let response = Response(data) {
                print("Response message: ", response.response.first?.content.msg)
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
}



