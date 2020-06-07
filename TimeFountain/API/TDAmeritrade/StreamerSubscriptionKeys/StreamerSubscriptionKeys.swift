//
//  StreamerSubscriptionKeys.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/30/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URLRequest {
    
    static func streamerSubscriptionKeys(
        accountIds: [String] = [Bundle.tdAccount_id].compactMap { $0 },
        accessToken token: String = Bundle.td_AccessToken
    ) -> URLRequest {
        URLRequest(
            url: URL.streamerSubscriptionKeys(accountIds: accountIds),
            headers: [String: String].forAccess(token),
            method: .GET
        )
    }
}

extension URL {
    
    fileprivate static func streamerSubscriptionKeys(
        accountIds: [String] 
    ) -> URL {
        return TDAmeritradeURL(paths: .userprincipals, .streamersubscriptionkeys)
            .accountIds(accountIds)
            .build
    }
}


extension TDAmeritradeURL {
    
    func accountIds(_ accountIds: [String] = [.accessToken]) -> TDAmeritradeURL {
        return kv(.accountIds, accountIds.joined(separator: ","))
    }
}
