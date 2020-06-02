//
//  Authorizations.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Authorizations: Codable {
    let advancedMargin, apex, levelTwoQuotes, marginTrading, scottradeAccount, stockTrading, streamerAccess, streamingNews: Bool
    let optionTradingLevel: String
}

