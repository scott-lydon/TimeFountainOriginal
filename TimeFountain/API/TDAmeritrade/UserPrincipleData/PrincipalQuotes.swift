//
//  PrincipalQuotes.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct PrincipalQuotes: Codable {
    let isNyseDelayed, isNasdaqDelayed, isOpraDelayed, isAmexDelayed: Bool
    let isCmeDelayed, isIceDelayed, isForexDelayed: Bool
}
