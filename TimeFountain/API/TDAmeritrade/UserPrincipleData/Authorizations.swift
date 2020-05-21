//
//  Authorizations.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Authorizations: Codable {
    let apex, levelTwoQuotes, stockTrading, marginTrading: Bool
    let streamingNews: Bool
    let optionTradingLevel: String
    let streamerAccess, advancedMargin, scottradeAccount: Bool
}
