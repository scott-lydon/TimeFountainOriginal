//
//  RefreshToken.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/7/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import Alamofire

extension URL {

    static func refreshToken(
        refreshToken: String? = Keychain.loadFrom(key: .refreshTokenKey),
        updateKeychain: Bool = true,
        tokenAction: @escaping TokenAction
    ) {
        print(String.refreshMessage(refreshToken, or: String.refreshTokenLiteral.fromCredentials))
        Alamofire.request(
            TDAmeritradeURL(paths: .oauth2, .token).build.absoluteString,
            method: .post,
            parameters: .parameters(
                refreshToken ?? String.refreshTokenLiteral.fromCredentials
            ),
            encoding:  URLEncoding.default,
            headers: .defaultHeader
        ).responseJSON { response in
            switch(response.result) {
            case.success(_): // let data
                guard let data = response.data,
                    let token = Token(data) else { return }
                if updateKeychain {
                    Keychain.save(token)
                }
                tokenAction(token)
            case.failure(let error):
                print("Not Success",error)
            }
        }
    }
}

extension String {
    
    static let failedToGetRefreshToken: String = "Could not get a refresh token and access token from the keychain nor the credentials.string file OR you used non-default arguments"
    
    static let passedNilRefreshToken: String = "The keychains were empty so we are getting the accesstoken and refresh token from the credentials string page.  This should only happen every 90 days or after we use the getTokens.py file OR you used non default arguments"
    
    static func refreshMessage(_ refreshToken: String?, or fromCredentials: String) -> String {
        if let _ = refreshToken {
            return ""
            // Keychain provides the value.
        } else if fromCredentials != "" {
           return String.passedNilRefreshToken
        } else {
            return String.failedToGetRefreshToken
        }
    }
}
