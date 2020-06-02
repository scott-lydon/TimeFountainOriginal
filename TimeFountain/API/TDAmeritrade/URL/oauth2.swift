//
//  authURL.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/28/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

enum GrantType: String {
    case authorization_code, refresh_token
}

enum AccessType: String {
    case offline
}

extension URLRequest {
    static func oauth2(
        grant_type: GrantType = .authorization_code,
        refresh_token: String? = nil,
        access_type: AccessType? = nil,
        code: String,
        client_id: String = Bundle.td_api_key!, // A crash is better than wasting my sisngle auth opportunity.
        redirect_uri: String = "http://localhost"
    ) -> URLRequest  {
        let url = URL.oauth2(
            grant_type: grant_type,
            refresh_token: refresh_token,
            access_type: access_type,
            code: code,
            client_id: client_id,
            redirect_uri: redirect_uri
        )
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        return request
    }
}

// https://developer.tdameritrade.com/authentication/apis/post/token-0
extension URL {
    
    static func oauth2(
        grant_type: GrantType,
        refresh_token: String? = nil,
        access_type: AccessType? = nil,
        code: String? = nil,
        client_id: String = Bundle.td_api_key!,
        redirect_uri: String? = nil
    ) -> URL {
        return TDAmeritradeURL(paths: .oauth2, .token)
            .grant_type(grant_type)
            .refresh_token(refresh_token)
            .access_type(access_type)
            .code(code)
            .client_id(client_id)
            .redirect_uri(redirect_uri)
            .build
    }
}


extension TDAmeritradeURL {

    func grant_type(_ grant_type: GrantType) -> TDAmeritradeURL {
        return kv(.grant_type, grant_type.rawValue)
    }
    
    func refresh_token(_ refresh_token: String?) -> TDAmeritradeURL {
        guard let refresh_token = refresh_token else { return self }
        return kv(.refresh_token, refresh_token)
    }
    
    func access_type(_ access_type: AccessType?) -> TDAmeritradeURL {
        guard let access_type = access_type else { return self }
        return kv(.access_type, access_type.rawValue)
    }

    func code(_ code: String?) -> TDAmeritradeURL {
        guard let code = code else { return self }
        return kv(.code, code)
    }

    func client_id(_ client_id: String) -> TDAmeritradeURL {
        return kv(.client_id, client_id)
    }
    
    func redirect_uri(_ redirect_uri: String?) -> TDAmeritradeURL {
        guard let redirect_uri = redirect_uri else { return self }
        return kv(.redirect_uri, redirect_uri)
    }
}
