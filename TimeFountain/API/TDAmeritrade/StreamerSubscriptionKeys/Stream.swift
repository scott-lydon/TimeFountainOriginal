//
//  Stream.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/3/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct TDStream: Codable {
    let requests: [Request]
    
    init?(principals: UserPrincipals, requests parts: [Request.Parts]) {
        guard let login: Request = .login(principals),
            let first = principals.accounts?.first else { return nil }
        self.requests = [login] + parts.map {
            Request(
                account: first.accountID,
                source: principals.streamerInfo.token,
                parts: $0
            )
        }
    }
}

enum StreamService: String, Codable {
    case ADMIN, LEVELONE_EQUITY, QUOTE, OPTION, LEVELONE_FUTURES //paid NEWS_HEADLINE
}

enum Command: String, Codable {
    case LOGIN, STREAM, QOS, SUBS, ADD, UNSUBS, VIEW, LOGOUT
}

struct Request: Codable {
    let service: StreamService
    let requestid: String
    let command: Command
    let account: String
    let source: String
    let parameters: Parameters
    
    struct Parts {
        let service: StreamService
        let requestid: Int
        let command: Command
        let parameters: Parameters

        static func quotes(_ parameters: QuoteParams) -> Parts {
            Parts(
                service: .QUOTE,
                requestid: 1,
                command: .SUBS,
                parameters: parameters
            )
        }
    }
    
    /// DOCS: https://developer.tdameritrade.com/content/streaming-data
    static func login(_ principals: UserPrincipals) -> Request? {
        guard let firstAccount = principals.accounts?.first,
            let credentials = principals.credentials else {
                print("ERROR: There was no account in the principals returned OR accounts were not set OR credentials property returned nil on User Principals.  accounts: \(String(describing: principals.accounts?.isEmpty)) ?? false)), firstAccount: \(String(describing: principals.accounts?.first)), principals.credentilas: \(String(describing: principals.credentials))")
            return nil
        }
        return Request(
            service: .ADMIN,
            requestid: 0,
            command: .LOGIN,
            account: firstAccount.accountID,
            source: principals.streamerInfo.appID,
            parameters: UserPrincipals.LoginParams(
                credential: credentials,
                token: principals.streamerInfo.token
            )
        )
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
       case LoginParamsKey, QuoteParamsKey, service, requestid, command, account, source
    }
    
    init(
        account: String,
        source: String,
        parts: Parts
    ) {
        self.service = parts.service
        self.requestid = String(parts.requestid)
        self.command = parts.command
        self.account = account
        self.source = source
        self.parameters = parts.parameters
    }
    
    init(
        service: StreamService,
        requestid: Int,
        command: Command,
        account: String,
        source: String,
        parameters: Parameters
    ) {
        self.service = service
        self.requestid = String(requestid)
        self.command = command
        self.account = account
        self.source = source
        self.parameters = parameters
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let requestParam = try? values.decode(QuoteParams.self, forKey: .QuoteParamsKey) {
            self.parameters = requestParam
        } else if let loginParam = try? values.decode(UserPrincipals.LoginParams.self, forKey: .LoginParamsKey) {
            self.parameters = loginParam
        } else {
            throw DecodingError.valueNotFound(Parameters.Type.self, DecodingError.Context(codingPath: CodingKeys.allCases, debugDescription: "could not decode parameters for any of the keys listed values"))
        }
        self.service = try values.decode(StreamService.self, forKey: .service)
        self.requestid = try values.decode(String.self, forKey: .requestid)
        self.command = try values.decode(Command.self, forKey: .command)
        self.account = try values.decode(String.self, forKey: .account)
        self.source = try values.decode(String.self, forKey: .source)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let params = parameters as? UserPrincipals.LoginParams {
            try container.encode(params, forKey: .LoginParamsKey)
        } else if let params = parameters as? QuoteParams {
            try container.encode(params, forKey: .QuoteParamsKey)
        } else {
            throw EncodingError.invalidValue(Parameters.self, EncodingError.Context(codingPath: CodingKeys.allCases, debugDescription: "Unrecognized type conforming to Parameters, not included in the keys."))
        }
        try container.encode(service, forKey: .service)
        try container.encode(requestid, forKey: .requestid)
        try container.encode(command, forKey: .command)
        try container.encode(account, forKey: .account)
        try container.encode(source, forKey: .source)
    }
}

protocol Parameters: Codable {}

extension UserPrincipals {
    
    struct LoginParams: Parameters {
        var credential: String
        var version: String
        var token: String
        
        init(credential: Credentials, version: String = "1.0", token: String) {
            self.credential = credential.stringString.queryString
            self.version = version
            self.token = token
        }
    }
    
    var credentials: Credentials? {
        Credentials(userPrincipals: self)
    }
    
    struct Credentials: Codable {
        var userid: String
        var token: String
        var company: String
        var segment: String
        var cddomain: String
        var usergroup: String
        var accesslevel: String
        var authorized: String
        var timestamp: String
        var appid: String
        var acl: String
        
        init?(
            userPrincipals: UserPrincipals,
            authorized: String = "Y"
        ) {
            guard let firstAccount = userPrincipals.accounts?.first else {
                assertionFailure("Couldn't get an account from user principals")
                return nil
            }
            guard let tokenTimeStamp = userPrincipals.streamerInfo.tokenTimeStamp?.timeIntervalSince1970 else {
                assertionFailure("Couldn't get an account from user principals")
                return nil
            }
            self.userid = firstAccount.accountID
            self.token = userPrincipals.streamerInfo.token
            self.company = firstAccount.company
            self.segment = firstAccount.segment
            self.cddomain = firstAccount.accountCDDomainID
            self.usergroup = userPrincipals.streamerInfo.userGroup
            self.accesslevel = userPrincipals.streamerInfo.accessLevel
            self.authorized = authorized
            self.timestamp = String(Int(tokenTimeStamp) * 1000)
            self.appid = userPrincipals.streamerInfo.appID
            self.acl = userPrincipals.streamerInfo.acl
        }
    }
}

/*
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
 */


struct QuoteParams: Parameters {
    let keys: String
    let fields: String
    
    init(_ tickers: [Ticker], fields: Field...) {
        self.init(tickers, fields)
    }
    
    init(_ tickers: [Ticker], _ fields: [Field]) {
        self.keys = tickers.map { $0.rawValue }.joined(separator: ",")
        self.fields = fields.map { String($0.rawValue) }.joined(separator: ",")
    }
}


enum Field: Int {
    case Symbol = 0,
    Bid_Price,
    Ask_Price,
    Last_Price,
    Bid_Size,
    Ask_Size,
    Ask_ID,
    Bid_ID,
    Total_Volume,
    Last_Size,
    Trade_Time,
    Quote_Time,
    High_Price,
    Low_Price,
    Bid_Tick,
    Close_Price,
    Exchange_ID,
    Marginable,
    Shortable,
    Island_Bid,
    Island_Ask,
    Island_Volume,
    Quote_Day,
    Trade_Day,
    Volatility,
    Description,
    Last_ID,
    Digits,
    Open_Price,
    Net_Change,
    the_52_Week_High,
    the_52_Week_Low,
    PE_Ratio,
    Dividend_Amount,
    Dividend_Yield,
    Island_Bid_Size,
    Island_Ask_Size,
    NAV,
    Fund_Price,
    Exchange_Name,
    Dividend_Date,
    Regular_Market_Quote,
    Regular_Market_Trade,
    Regular_Market_Last_Price,
    Regular_Market_Last_Size,
    Regular_Market_Trade_Time,
    Regular_Market_Trade_Day,
    Regular_Market_Net_Change,
    Security_Status,
    Mark,
    Quote_Time_in_Long,
    Trade_Time_in_Long,
    Regular_Market_Trade_Time_in_Long
}
