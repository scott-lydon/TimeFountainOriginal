//
//  Mover.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Mover: Codable {
    let change: Int
    let moverDescription, direction: String
    let last: Int
    let symbol: String
    let totalVolume: Int

    enum CodingKeys: String, CodingKey {
        case change
        case moverDescription = "description"
        case direction, last, symbol, totalVolume
    }
}
