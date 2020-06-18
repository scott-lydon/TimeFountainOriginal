//
//  URL+Account.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/18/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


extension URLRequest {
    
     static func account(
        apiKey: String? = Bundle.td_api_key,
        accountNum: String = Bundle.tdAccount_id,
        accountAction: @escaping (Account)->Void
    ) {
        URLRequest.account(apiKey: apiKey, accountNum: accountNum).getData { data in
            guard let account = Account(data) else { return }
            accountAction(account)
        }
    }
    
    
    static func account(
        apiKey: String? = Bundle.td_api_key,
        accountNum: String = Bundle.tdAccount_id
    ) -> URLRequest {
        URLRequest(
            url: URL.account(),
            headers: [String : String].forAccess(accountNum),
            method: .GET
        )
    }
}

extension URL {
    
    
    
    static func account(
        apiKey: String? = Bundle.td_api_key,
        accountNum: String = Bundle.tdAccount_id
    ) -> URL {
        return TDAmeritradeURL(paths: TDAmeritradeURL.Path.accounts.rawValue, accountNum)
            .apiKey(apiKey)
            .build
    }
}
