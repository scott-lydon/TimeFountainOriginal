//
//  TDResponse.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/25/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let response: [ResponseElement]
}

// MARK: - ResponseElement
struct ResponseElement: Codable {
    let service, requestid, command: String
    let timestamp: Int
    let content: Content
}

// MARK: - Content
struct Content: Codable {
    let code: Int
    let msg: String
}


// MARK: - Error
struct TDError: Codable {
    let error: String
}
