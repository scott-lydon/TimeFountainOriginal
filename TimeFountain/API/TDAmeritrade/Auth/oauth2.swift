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



// https://developer.tdameritrade.com/authentication/apis/post/token-0
extension URL {
    
    
    /*
     refresh token, use the following parameters with the Post Access Token API (https://developer.tdameritrade.com/authentication/apis/post/token-0) to create only an access token:
    -------------------------------------------
     grant_type: refresh_token
     refresh_token: <insert valid refresh token>
     client_id: <insert consumer key>
     ------------------------------------------
     */
    static func accessToken(
        grant_type: GrantType = .refresh_token,
        refresh_token: String = Bundle.td_refreshToken,
        client_id: String = Bundle.td_api_key!
    ) -> URL {
        TDAmeritradeURL(paths: .oauth2, .token)
        .grant_type(grant_type)
        .refresh_token(refresh_token)
        .client_id(client_id)
        .build
    }
        
    /// Gets the refresh token and access token.  Recommended to call every 90 days.
    @discardableResult
    static func tokenRefresh(
        client_id: String = Bundle.td_api_key!,
        refreshTokenAction: @escaping TokenAction
    ) -> URL {
        let url = URL.refreshToken(
            grant_type: .refresh_token,
            refresh_token: String.refreshTokenLiteral.fromCredentials,
            access_type: .offline,
            client_id: client_id
        )
        url.getData { data in
            guard let token = Token(data) else { return }
            refreshTokenAction(token)
        }
        url.getJSON { json in
            print("JSON was: ", json)
        }
        return url
    }
    
    /// Gets the refresh token and access token.  Recommended to call every 90 days.
    /// As your refresh token is about to expire, use the following parameters to create a new refresh token:
    ///--------------------------------------------
    /// grant_type: refresh_token
    /// refresh_token: <insert valid refresh token>
    /// access_type: offline
    /// client_id: <insert consumer key>
    /// -------------------------------------------
    static func refreshToken(
        grant_type: GrantType = .refresh_token,
        refresh_token: String = String.refreshTokenLiteral.fromCredentials,
        access_type: AccessType = .offline,
        client_id: String = Bundle.td_api_key!
    ) -> URL {
        TDAmeritradeURL(paths: .oauth2, .token)
//            .grant_type(grant_type)
//            .refresh_token(refresh_token)
//            .access_type(access_type)
//            .client_id(client_id + "%40AMER.OAUTHAP")
            .build
    }
    
    static func getAccessToken(
        grant_type: GrantType = .refresh_token, //refresh_token
        refresh_token: String, //{REFRESH TOKEN}
        client_id: String = Bundle.td_api_key!,
        accessToken: @escaping StringAction
    ) {
        let url = URL.newToken(
            grant_type: grant_type,
            refresh_token: refresh_token,
            client_id: client_id
        )
        url.getData { data in
            print(String(data) ?? "Could not convert data to String")
            guard let token = String(data) else { return }
            accessToken(token)
        }
        url.getJSON { json in
            print(json)
        }
    }
    
    static func newToken(
        grant_type: GrantType, //refresh_token
        refresh_token: String, //{REFRESH TOKEN}
        client_id: String = Bundle.td_api_key!
    ) -> URL {
        TDAmeritradeURL(paths: .oauth2, .token)
            .grant_type(grant_type)
            .refresh_token(refresh_token)
            .client_id(client_id)
            .build
    }
    
    static func oauth2(
        grant_type: GrantType,
        refresh_token: String? = nil,
        access_type: AccessType? = nil,
        code: String? = nil,
        client_id: String = Bundle.td_api_key!,
        redirect_uri: String? = nil
    ) -> URL {
        TDAmeritradeURL(paths: .oauth2, .token)
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
