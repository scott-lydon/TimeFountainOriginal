//
//  UserPrincipals.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension String {
    static var tdAmeritradeFormat: String {
        "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    static var commonDateFormat: String {
        "YYYY-MM-dd HH:mm:ss"
    }
}

extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}

extension DateFormatter {
    convenience init(
        _ format: String,
        timeZone: TimeZone? = TimeZone(secondsFromGMT: 0),
        calendar: Calendar = Calendar(identifier: .iso8601)
    ) {
        self.init()
        self.calendar = calendar
        self.timeZone = timeZone
        self.dateFormat = format
    }
}

struct UserPrincipals: Codable {
    let loginTime: String // Date
    let authToken: String
    let streamerSubscriptionKeys: StreamerSubscriptionKeys
    let lastLoginTime: String // Date
    let primaryAccountID: String
    let quotes: Quotes
    let streamerInfo: StreamerInfo
    let userCDDomainID: String
    let accounts: [Account]?
    let userID: String
    let tokenExpirationTime: String // Date
    let professionalStatus: String
    let stalePassword: Bool
    let accessLevel: String
    
    var loginTimeAsDate: Date? {
        loginTime.tdDate
    }
    
    var lastLoginTimeDate: Date? {
        lastLoginTime.tdDate
    }
    
    var tokenExpirationTimeDate: Date? {
        tokenExpirationTime.tdDate
    }
    
    var loginRequestDictionary: [String: Any] {
        guard let firstAccount = accounts?.first else {
            assertionFailure("Couldn't get an account from user principals")
            return [:]
        }
        let qstring = firstAccountCredentials.queryString
        print("QString: --->\n\n", qstring, "\n\n<-----")
        return [
            "requests": [[
                "service": "ADMIN",
                "command": "LOGIN",
                "requestid": 0,
                "account": firstAccount.accountID,
                "source": streamerInfo.appID,
                "parameters": [
                    "credential": qstring,
                    "token": streamerInfo.token,
                    "version": "1.0"
                ]
            ]]
        ]
    }
    
    var loginRequestString: String {
        loginRequestDictionary.stringified ?? "Login request failed to stringify"
    }
    
    var loginURLRequest: URLRequest? {
        guard let url = URL.tdSocket(principals: self) else {
            print("The url failed. ")
            return nil
        }
        return URLRequest(url: url)
    }
    
    var firstAccountCredentials: [String: String] {
        guard let firstAccount = accounts?.first else {
            assertionFailure("Couldn't get an account from user principals")
            return [:]
        }
        guard let tokenTimeStamp = streamerInfo.tokenTimeStamp?.timeIntervalSince1970 else {
            assertionFailure("Couldn't get an account from user principals")
            return [:]
        }
       
        let creds =  [
            "userid":firstAccount.accountID,
            "token": streamerInfo.token,
            "company": firstAccount.company,
            "segment": firstAccount.segment,
            "cddomain": firstAccount.accountCDDomainID,
            "usergroup": streamerInfo.userGroup,
            "accesslevel": streamerInfo.accessLevel,
            "authorized": "Y",
            "timestamp": String(Int(tokenTimeStamp) * 1000 ),
            "appid": streamerInfo.appID,
            "acl": streamerInfo.acl,
        ]
        print("Credentials are ---->\n\n", creds, "\n\n<--------")
        return creds
    }

    
    // https://www.datetimeformatter.com/how-to-format-date-time-in-swift/
    
    init?(dataWithDate data: Data) {
      //  guard let data = Data(data) else { return nil }
        let decoder = JSONDecoder()
        do {
            self = try decoder.decode(Self.self, from: data)
        } catch let err {
            print("could not decode UserPrincipals because: " + err.localizedDescription)
            return nil
        }
    }

    enum CodingKeys: String, CodingKey {
        case loginTime, authToken, streamerSubscriptionKeys, lastLoginTime
        case primaryAccountID = "primaryAccountId"
        case quotes, streamerInfo
        case userCDDomainID = "userCdDomainId"
        case accounts
        case userID = "userId"
        case tokenExpirationTime, professionalStatus, stalePassword, accessLevel
    }
}



struct Preferences: Codable {
    let equityTaxLotMethod, defaultEquityOrderLegInstruction, optionTaxLotMethod, defaultEquityOrderType: String
    let expressTrading, directEquityRouting: Bool
    let authTokenTimeout: String
    let directOptionsRouting: Bool
    let defaultAdvancedToolLaunch, defaultEquityOrderDuration: String
    let defaultEquityQuantity: Int
    let mutualFundTaxLotMethod, defaultEquityOrderPriceLinkType, defaultEquityOrderMarketSession: String
}

struct SurrogateIDS: Codable {
    let investools, min, sts, opinionLab: String
    let ePay, marketWatch, wallStreetStrategies, flybits: String
    let scarr, wsod, siteCatalyst, layer: String
    let briefingTrader, marketEdge, sp, ef: String
    let mstar, pws, mgp, vce: String
    let localytics, zacks, havas, dart: String
    let gk, bozel, vb: String

    enum CodingKeys: String, CodingKey {
        case investools = "Investools"
        case min = "MIN"
        case sts = "STS"
        case opinionLab = "OpinionLab"
        case ePay
        case marketWatch = "Market Watch"
        case wallStreetStrategies = "WallStreetStrategies"
        case flybits = "Flybits"
        case scarr = "SCARR"
        case wsod = "WSOD"
        case siteCatalyst = "SiteCatalyst"
        case layer = "Layer"
        case briefingTrader = "BriefingTrader"
        case marketEdge = "Market Edge"
        case sp = "SP"
        case ef = "EF"
        case mstar = "MSTAR"
        case pws = "PWS"
        case mgp = "MGP"
        case vce = "VCE"
        case localytics = "Localytics"
        case zacks = "Zacks"
        case havas = "HAVAS"
        case dart = "DART"
        case gk = "GK"
        case bozel = "BOZEL"
        case vb = "VB"
    }
}

struct Quotes: Codable {
    let isNyseDelayed, isNasdaqDelayed, isAmexDelayed, isCmeDelayed: Bool
    let isIceDelayed, isOpraDelayed, isForexDelayed: Bool
}
