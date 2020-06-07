//
//  URL+Key.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URL {
    
    enum Path {
        case accounts, orders, marketdata, instruments, ticker(String), oauth2, userprincipals, watchlists, pricehistory, movers, chains, hours, token, quotes, transactions, preferences, streamersubscriptionkeys
    }
}


extension TDAmeritradeURL {
    
    enum Path: String {
        case marketdata, pricehistory, oauth2, userprincipals, token, auth, streamersubscriptionkeys, accounts, orders
    }
    
    enum Key: String {
        case apikey
        case periodType
        case period
        case frequencyType
        case frequency
        case endDate
        case startDate
        case needsExtendedHoursData
        case fields
        case grant_type
        case refresh_token
        case access_type
        case code
        case client_id
        case response_type, redirect_uri
        case accountIds
        case accounts
        
//        case access_token
//        case allowsCourtesyCalls
//        case alwaysInUse
//        case assert
        
        func string(from value: String) -> String {
            return "\(rawValue.scaped ?? "")=\(value.scaped ?? "")&"
        }
    }
    

    
}
