//
//  UserPrincipals.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct UserPrincipals: Codable {
    let authToken, userID, userCDDomainID, primaryAccountID: String
    let lastLoginTime, tokenExpirationTime, loginTime, accessLevel: String
    let stalePassword: Bool
    let streamerInfo: StreamerInfo
    let professionalStatus: String
    let quotes: Quotes
    let streamerSubscriptionKeys: StreamerSubscriptionKeys
    let accounts: [Account]

    enum CodingKeys: String, CodingKey {
        case authToken
        case userID = "userId"
        case userCDDomainID = "userCdDomainId"
        case primaryAccountID = "primaryAccountId"
        case lastLoginTime, tokenExpirationTime, loginTime, accessLevel, stalePassword, streamerInfo, professionalStatus, quotes, streamerSubscriptionKeys, accounts
    }
}
