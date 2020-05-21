//
//  AccountPrincipal.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Account: Codable {
    let accountID, accountDescription, displayName, accountCDDomainID: String
    let company, segment, surrogateIDS: String
    let preferences: PreferencesPrincipal
    let acl: String
    let authorizations: Authorizations

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case accountDescription = "description"
        case displayName
        case accountCDDomainID = "accountCdDomainId"
        case company, segment
        case surrogateIDS = "surrogateIds"
        case preferences, acl, authorizations
    }
}
