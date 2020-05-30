//
//  UserPrincipalsURL.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/28/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URL {
    
    static func userprincipals(
        apiKey: String? = Bundle.td_api_key,
        fields: [UserPrincipalOption] = []
    ) -> URL {
        return TDAmeritradeURL(paths: .userprincipals)
            .apiKey(apiKey)
            .fields(fields)
            .build
    }
    
    enum UserPrincipalOption: String {
        case streamerSubscriptionKeys,
        streamerConnectionInfo,
        preferences,
        surrogateIds
    }
}


extension TDAmeritradeURL {
    
    func fields(_ fields: [URL.UserPrincipalOption]) -> TDAmeritradeURL {
        guard !fields.isEmpty else { return self }
        return kv(.fields, fields.map { $0.rawValue }.joined(separator: ",") )
    }
}
