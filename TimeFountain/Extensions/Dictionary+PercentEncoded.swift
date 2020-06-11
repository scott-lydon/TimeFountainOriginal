//
//  Dictionary.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/7/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Dictionary {
    var percentEncoded: Data? {
        map { key, value in
            "\(key)".escaped + "=" + "\(value)".escaped
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension String {
    var escaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
    }
}

