//
//  Token.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

typealias TokenAction = (Token) -> Void

/*
 // MARK: - Token
 struct Token: Codable {
     let accessToken, refreshToken, scope: String
     let expiresIn, refreshTokenExpiresIn: Int
     let tokenType: String

     enum CodingKeys: String, CodingKey {
         case accessToken = "access_token"
         case refreshToken = "refresh_token"
         case scope
         case expiresIn = "expires_in"
         case refreshTokenExpiresIn = "refresh_token_expires_in"
         case tokenType = "token_type"
     }
 }
 
 */

struct Token: Codable {
    let accessToken, refreshToken, tokenType: String
    let expiresIn: Int
    let scope: String
    let refreshTokenExpiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case refreshTokenExpiresIn = "refresh_token_expires_in"
    }
    
    func write(to path: String = "iOS/TimeFountain/TimeFountain/Credentials.strings") {
        newCredentialsFileContent.write(to: path)
    }
    
    var newCredentialsFileContent: String {
        newCredentialsFileDictionary.stringFile
    }
    
    var newCredentialsFileDictionary: [String: String] {
        [String: String](
            accessToken: self.accessToken,
            refreshToken: self.refreshToken
        )
    }
}


extension Keychain {
    static func save(_ token: Token) {
        Keychain.save(key: .accessTokenKey, value: token.accessToken)
        Keychain.save(key: .refreshTokenKey, value: token.refreshToken)
    }
}
