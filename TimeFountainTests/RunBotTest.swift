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
        var getAccountcounter = 0
        let givePrediction = expectation(description: "givePrediction")
        var givePredictionCounter = 0
        let confirmationExp = expectation(description: "confirmation")
        var confirmationExpCounter = 0
        let model = TSLA()
        let ticker = String(describing: model.self)
        URL.runBot(
            ticker: "GNC", //ticker
            allowance: 10,
            closeTimeFromNow: 4,
            sellUponClose: true,
            dataFrameQuoteAction: { dataFrame, quote in
                if givePredictionCounter == 0 {
                    givePrediction.fulfill()
                    givePredictionCounter = 1
                }
                return model.prediction(from: dataFrame)
        }, accountUpdate: { account in
            print("Output account on screen:", account.currentBalances.availableFunds)
            if getAccountcounter == 0 {
                getAccount.fulfill()
                getAccountcounter = 1
            }
        }, transaction: { confirmation in
            if confirmationExpCounter == 0 {
                confirmationExp.fulfill()
                confirmationExpCounter = 1
            }
            print(confirmation)
        })
        wait(for: [getAccount, givePrediction, confirmationExp], timeout: 8)
        //waitForExpectations(timeout: 8, handler: nil)
    }
}
