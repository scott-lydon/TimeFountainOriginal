//
//  String.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension String {
    
    var scaped: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    init(key: String, _ value: String) {
        self = "\(key)=\(value.scaped ?? "")&"
    }
    
    static var baseURL: String {
        return "https://api.tdameritrade.com/v1/"
    }
}
