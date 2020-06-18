//
//  placeOrderTest.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 6/8/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//


import Foundation
import XCTest
@testable import TimeFountain
import Alamofire

extension TimeFountainTests {    
    
    func testPlaceOrder() {
        let placeOrder = expectation(description: "placeOrder")
        let cancelOrder = expectation(description: "cancel Order")
        URL.place(
            order: BuyMarketStock(
                ticker: "DXF",
                quantity: 1
            )
        ) { confirmation in
            print(confirmation)
            placeOrder.fulfill()
            URL.cancel(orderid: String(confirmation.orderID)) { status in
                print(status ?? "nil")
                cancelOrder.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}

