//
//  AccountPrincipal.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


struct Account: Codable {
    let displayName, accountID, accountCDDomainID, segment: String
    let preferences: Preferences
    let company, acl: String
    let authorizations: Authorizations
    let surrogateIDS: SurrogateIDS

    enum CodingKeys: String, CodingKey {
        case displayName
        case accountID = "accountId"
        case accountCDDomainID = "accountCdDomainId"
        case segment, preferences, company, acl, authorizations
        case surrogateIDS = "surrogateIds"
    }
}
