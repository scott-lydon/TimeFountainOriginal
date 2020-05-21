//
//  Token.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

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
}
