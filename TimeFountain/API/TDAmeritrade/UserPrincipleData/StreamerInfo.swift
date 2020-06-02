//
//  StreamerInfo.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct StreamerInfo: Codable {
    let streamerBinaryURL: String
    let tokenTimestamp: String // Date
    let acl, appID, streamerSocketURL, token: String
    let userGroup, accessLevel: String
    
    var tokenTimeStamp: Date? {
        tokenTimestamp.tdDate
    }

    enum CodingKeys: String, CodingKey {
        case streamerBinaryURL = "streamerBinaryUrl"
        case tokenTimestamp, acl
        case appID = "appId"
        case streamerSocketURL = "streamerSocketUrl"
        case token, userGroup, accessLevel
    }
}
