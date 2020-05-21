//
//  StreamerInfo.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct StreamerInfo: Codable {
    let streamerBinaryURL, streamerSocketURL, token, tokenTimestamp: String
    let userGroup, accessLevel, acl, appID: String

    enum CodingKeys: String, CodingKey {
        case streamerBinaryURL = "streamerBinaryUrl"
        case streamerSocketURL = "streamerSocketUrl"
        case token, tokenTimestamp, userGroup, accessLevel, acl
        case appID = "appId"
    }
}
