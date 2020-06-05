//
//  String.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension String {
    
    static var baseURL: String {
        "https://api.tdameritrade.com/v1/"
    }
    
    static var authURL: String {
        "https://auth.tdameritrade.com/"
    }
    
    static var accessToken: String {
        String.accessTokenLiteral.localized(fileName: "Credentials")
    }
    
    static var accessTokenLiteral: String {
        "accessToken"
    }
    
    static var refreshTokenLiteral: String {
        "refreshToken"
    }
}
