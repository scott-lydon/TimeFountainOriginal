//
//  StreamedQuote.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/11/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

// MARK: - StreamedQuote
struct StreamedQuote: Codable {
    let data: [Datum]
    
    struct Datum: Codable {
        let service: StreamService
        let timestamp: Int
        let command: Command
        let content: [Content]
        
        struct Content: Codable {
            let the15: Double
            let key: String
            let delayed: Bool
            let assetMainType, cusip: String

            enum CodingKeys: String, CodingKey {
                case the15 = "15"
                case key, delayed, assetMainType, cusip
            }
        }
    }
}

