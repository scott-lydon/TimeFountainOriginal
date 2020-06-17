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

typealias PrincipalAction = (UserPrincipals?)->Void

extension URLRequest {
    
    /// Main interface.  Robust, ensures that if a new device is used, then a new call to get principals is made.
    static func userPrincipals(
        fields: [UserPrincipalOption] = [
        .preferences,
        .streamerConnectionInfo,
        .streamerSubscriptionKeys,
        .surrogateIds,
        ],
        action: @escaping PrincipalAction
    ) {
        print(fields, fields.count)
        let prinicpalsReq = URLRequest.userprincipals(fields: fields)
        print(prinicpalsReq.url?.absoluteString)
        prinicpalsReq.getData { data in
            action(UserPrincipals(dataWithDate: data))
        }
        prinicpalsReq.get { json in
            print("Fetched UserPrincipals, they were:\n", json?.asJSON ?? "json was nil! :(")
        }
    }
    
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
    
    /// Alternative interface for URLRequest
    ///  Robust, ensures that if a new device is used, then a new call to get principals is made.
    static func userPrincipals(
        fields: [UserPrincipalOption] = [
            .preferences,
            .streamerConnectionInfo,
            .streamerSubscriptionKeys,
            .surrogateIds,
        ],
        action: @escaping PrincipalAction
    ) {
        URLRequest.userPrincipals(fields: fields, action: action)
    }
    
    static func userprincipals(
        fields: [UserPrincipalOption] = []
    ) -> URL {
        let url = TDAmeritradeURL(paths: .userprincipals)
            .fields(fields)
            .build
        print(url.absoluteString)
        return url
    }
}


extension TDAmeritradeURL {
    
    fileprivate func fields(_ fields: [UserPrincipalOption]) -> TDAmeritradeURL {
        guard !fields.isEmpty else { return self }
        return kv(.fields, fields.map { $0.rawValue }.joined(separator: ",") )
    }
}
