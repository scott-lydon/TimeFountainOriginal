//
//  GetOrder.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/8/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import Alamofire

extension URL {
    
    static func get(
        order: String,
        apiKey: String? = Bundle.td_api_key,
        accountID: String = Bundle.tdAccount_id,
        confirmationAction: @escaping ConfirmationAction
    )  {
        URL.refreshToken { _ in
            var headers: [String: String] = .forAccess()
            headers["Content-Type"] = "application/json"
            Alamofire.request(
                TDAmeritradeURL(
                    paths: TDAmeritradeURL.Path.accounts.rawValue, accountID, TDAmeritradeURL.Path.orders.rawValue, order
                ).build.absoluteString,
                method: .get,
                encoding: JSONEncoding.default,
                headers: headers
            ).validate().responseJSON { responseData in
                print(#line, "data was: ", responseData.result.value ?? "nil")
                print("responseData: ", responseData, "\n", "responseData.response: ", responseData.response ?? "nil", "\nresponseData.data: ", responseData.data ?? "nil", "\n", "responseData.result: ", responseData.result, "\nresponseData.description: ", responseData.description, "\n", "responseData.response: ", responseData.request ?? "nil", "\nresponseData.value: ", responseData.value ?? "nil")
                guard let data = responseData.data,
                    let confirmation = OrderGet(data) else {
                        print("we failed :(")
                        return
                }
                confirmationAction(confirmation)
            }
        }
    }
}


extension TDAmeritradeURL {
    
    // EXAMPLE
//    func apiKey(_ apiKey: String? = Bundle.td_api_key) -> TDAmeritradeURL {
//        return kv(.apikey, apiKey)
//    }
}
