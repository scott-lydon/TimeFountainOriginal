//
//  UserDefaults.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static var baseUrlToUse: String {
        get {
            if let baseUrl = UserDefaults.standard.string(forKey: #function) {
                return baseUrl
            } else {
                // default
                ///return .localURL
                return .baseURL
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
    }
}
