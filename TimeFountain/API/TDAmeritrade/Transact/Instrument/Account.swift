//
//  Account.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/17/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

// MARK: - Account
struct Account: Codable {
    
    enum AccountType: String, Codable {
        case MARGIN, CASH
    }
    
    let type: AccountType
    let accountID: String
    let roundTrips: Int
    let isDayTrader, isClosingOnlyRestricted: Bool
    let positions: [Position]
    let orderStrategies: [OrderStrategy]
    let initialBalances: InitialBalances
    let currentBalances: Balances
    let projectedBalances: Balances

    enum CodingKeys: String, CodingKey {
        case type
        case accountID = "accountId"
        case roundTrips, isDayTrader, isClosingOnlyRestricted, positions, orderStrategies, initialBalances, currentBalances, projectedBalances
    }
}


