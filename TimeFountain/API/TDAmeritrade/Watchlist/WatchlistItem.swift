//
//  WatchlistItem.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct WatchlistItem: Codable {
    let sequenceID, quantity, averagePrice, commission: Int
    let purchasedDate: String
    let instrument: PurchaseInstrument
    let status: String

    enum CodingKeys: String, CodingKey {
        case sequenceID = "sequenceId"
        case quantity, averagePrice, commission, purchasedDate, instrument, status
    }
}


struct CreateWatchlistItem: Codable {
    let quantity, averagePrice, commission: Int
    let purchasedDate: String
    let instrument: PurchaseInstrument
}
