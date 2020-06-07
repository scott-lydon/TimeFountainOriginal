//
//  UserPrincipalsURL.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/28/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

enum UserPrincipalOption: String {
    case streamerSubscriptionKeys,
    streamerConnectionInfo,
    preferences,
    surrogateIds
}

extension URLRequest {
    
    static func userprincipals(
        apiKey: String? = Bundle.td_api_key,
        fields: [UserPrincipalOption] = [],
        accessToken token: String = Bundle.td_AccessToken
    ) -> URLRequest {
        URLRequest(
            url: URL.userprincipals(fields: fields),
            headers: [String : String].forAccess(token),
            method: .GET
        )
    }
}

extension URL {
    
    static func userprincipals(
        fields: [UserPrincipalOption] = []
    ) -> URL {
        return TDAmeritradeURL(paths: .userprincipals)
            .fields(fields)
            .build
    }
}


extension TDAmeritradeURL {
    
    func fields(_ fields: [UserPrincipalOption]) -> TDAmeritradeURL {
        guard !fields.isEmpty else { return self }
        return kv(.fields, fields.map { $0.rawValue }.joined(separator: ",") )
    }
}
