//
//  RunBotTest.swift
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

    func testRunBotTest() {
        let getAccount = expectation(description: "getAccount")
        let givePrediction = expectation(description: "givePrediction")
        let confirmationExp = expectation(description: "confirmation")
        let model = TSLA()
        let ticker = String(describing: model.self)
        URL.runBot(
            ticker: ticker,
            allowance: 10,
            closeTimeFromNow: 4,
            sellUponClose: true,
            dataFrameQuoteAction: { dataFrame, quote in
                givePrediction.fulfill()
                return model.prediction(from: dataFrame)
        }, accountUpdate: { account in
            print("Output account on screen:", account.currentBalances.availableFunds)
            getAccount.fulfill()
        }, transaction: { confirmation in
            confirmationExp.fulfill()
            print(confirmation)
        })
        waitForExpectations(timeout: 8, handler: nil)
    }
}
