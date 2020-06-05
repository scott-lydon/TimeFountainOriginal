//
//  Stream.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/3/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct TDStream: Codable {
    let requests: [Request]
}

struct Request: Codable {
    let service, requestid, command, account: String
    let source: String
    let parameters: Parameters
}

struct Parameters: Codable {
    let keys, fields: String
}
