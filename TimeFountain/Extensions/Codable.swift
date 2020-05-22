//
//  Codable.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Decodable {
    init?(_ data: Data) {
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch let err {
            print(err)
            return nil
        }
    }
}

extension Array where Element: Decodable {
    init?(_ data: Data) {
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch let err {
            print(err)
            return nil
        }
    }
}
