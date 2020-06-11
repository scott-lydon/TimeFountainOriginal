//
//  PlaceOrder.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/8/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import Alamofire

extension URL {
    
    typealias ConfirmationAction = (OrderGet) -> Void
    
    static func place(
        order: Order,
        accountID: String = Bundle.tdAccount_id,
        confirmationAction: @escaping ConfirmationAction
    ) {
        URL.refreshToken { _ in
            var headers: [String: String] = .forAccess()
            headers["Content-Type"] = "application/json"
            Alamofire.request(
                URL.placeOrder(accountID: accountID).absoluteString,
                method: .post,
                parameters: order.dictionary,
                encoding: JSONEncoding.default,
                headers:headers
            ).validate().responseData { dataResponse in
                print(dataResponse.response?.statusCode ?? "nil")
                guard let location = dataResponse.response?.allHeaderFields["Location"] as? String else { return }
                print(location)
                
                Alamofire.request(
                    location,
                    method: .get,
                    encoding: JSONEncoding.default,
                    headers: headers
                ).validate().responseJSON { responseData in
                    print("responseData: ", responseData, "\n", "responseData.response: ", responseData.response ?? "nil", "\nresponseData.data: ", responseData.data ?? "nil", "\n", "responseData.result: ", responseData.result, "\nresponseData.description: ", responseData.description, "\n", "responseData.response: ", responseData.request ?? "nil", "\nresponseData.value: ", responseData.value ?? "nil")
                    print(#line, "data was: ", responseData.result.value ?? "nil")
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
    
    static func placeOrder(
        accountID: String = Bundle.tdAccount_id
    ) -> URL {
        TDAmeritradeURL(paths:
            TDAmeritradeURL.Path.accounts.rawValue,
            accountID,
            TDAmeritradeURL.Path.orders.rawValue
        ).build
    }
}
