//
//  StreamerSubscriptionKey.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct StreamerSubscriptionKeys: Codable {
    let keys: [Key]
}

struct Key: Codable {
    let key: String
}
