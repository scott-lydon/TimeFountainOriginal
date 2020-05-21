//
//  Watchlist.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Watchlist: Codable {
    let name, watchlistID, accountID, status: String
    let watchlistItems: [WatchlistItem]

    enum CodingKeys: String, CodingKey {
        case name
        case watchlistID = "watchlistId"
        case accountID = "accountId"
        case status, watchlistItems
    }
}
