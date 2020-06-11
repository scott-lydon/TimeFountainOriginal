//
//  HeartBeat.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/11/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct HeartBeat: Codable {
    let notify: [Notify]
}

struct Notify: Codable {
    let heartbeat: String
}
