//
//  Instrument.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Instrument: Codable {
    let symbol, instrumentDescription, assetType: String

    enum CodingKeys: String, CodingKey {
        case symbol
        case instrumentDescription = "description"
        case assetType
    }
}
