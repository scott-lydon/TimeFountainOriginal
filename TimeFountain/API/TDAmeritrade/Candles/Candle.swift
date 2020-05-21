//
//  Candle.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Candle: Codable {
    let close, datetime, high, low: Int
    let candleOpen, volume: Int

    enum CodingKeys: String, CodingKey {
        case close, datetime, high, low
        case candleOpen = "open"
        case volume
    }
}
