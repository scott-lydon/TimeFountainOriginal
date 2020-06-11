//
//  GeneralOrderURL.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/8/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import Alamofire

enum ResponseStatus {
    case success, failure(Int)
    
    init(_ int: Int) {
        if int == 200 {
            self = .success
        } else {
            self = .failure(int)
        }
    }
}

extension URL {
    
    typealias ResponseStatusAction = (ResponseStatus?) -> Void
    
    static func cancel(
        orderid: String,
        confirmationAction: @escaping ResponseStatusAction
    ) {
        var headers: [String: String] = .forAccess()
        headers["Content-Type"] = "application/json"
        Alamofire.request(
            URL.order(orderID: orderid).absoluteString,
            method: .delete,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: headers
        ).validate().responseData { responseData in
            print("responseData: ", responseData, "\n", "responseData.response: ", responseData.response ?? "nil", "\nresponseData.data: ", responseData.data ?? "nil", "\n", "responseData.result: ", responseData.result, "\nresponseData.description: ", responseData.description, "\n", "responseData.response: ", responseData.request ?? "nil", "\nresponseData.value: ", responseData.value ?? "nil")
            print(responseData.response?.statusCode ?? "nil")
            if let status = responseData.response?.statusCode {
                confirmationAction(ResponseStatus(status))
            } else {
                confirmationAction(nil)
            }
        }
    }
    

    
    static func order(
        accountID: String = Bundle.tdAccount_id,
        orderID: String
    ) -> URL {
        TDAmeritradeURL(paths:
            TDAmeritradeURL.Path.accounts.rawValue,
            accountID,
            TDAmeritradeURL.Path.orders.rawValue,
            orderID
        ).build
    }
}
