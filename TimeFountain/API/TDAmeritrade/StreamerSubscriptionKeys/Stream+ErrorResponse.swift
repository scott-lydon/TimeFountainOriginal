//
//  Stream+ErrorResponse.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/10/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

// MARK: - OrderLeg
struct ErrorResponses: Codable {
    let response: [Response]
    var developerInput: String?
    
    
    
    struct Response: Codable {
        let service: StreamService
        let requestid: String
        let command: Command
        let timestamp: Int
        let content: Content
        
        struct Content: Codable {
            let code: Int
            let msg: String
        }
    }
}


