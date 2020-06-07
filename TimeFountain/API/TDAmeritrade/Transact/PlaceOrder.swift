//
//  PlaceOrder.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/5/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URLRequest {
    
    static func placeOrder(
        accountID: String = Bundle.tdAccount_id
     //   request: [String: Any]
    ) -> URLRequest {
        URLRequest(
            url: URL.placeOrder(accountID: accountID),
            headers: .forAccess()
        )
//        URLRequest(
//            url: URL.placeOrder(accountID: accountID),
//            headers: request(merge: .forAccess())
//        )
    }
}

extension URL {
    
    static func placeOrder(
        accountID: String = Bundle.tdAccount_id
    ) -> URL {
        TDAmeritradeURL(
            paths: TDAmeritradeURL.Path.accounts.rawValue, accountID, TDAmeritradeURL.Path.orders.rawValue)
            .build
    }
}
