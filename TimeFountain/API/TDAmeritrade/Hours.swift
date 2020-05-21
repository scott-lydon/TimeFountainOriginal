//
//  Hours.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct Hours: Codable {
    let category, date, exchange: String
    let isOpen: Bool
    let marketType, product, productName, sessionHours: String
}
