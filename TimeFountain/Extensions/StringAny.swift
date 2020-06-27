//
//  StringAny.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/1/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    var asJSON: String? {
        guard let jsonData = try? JSONSerialization.data(
            withJSONObject: self,
            options: []
            ) else { return nil }
        return String(data: jsonData, encoding: .ascii)
    }
    
    static func parameters(
        _ refreshToken: String,
        _ apiKey: String = "FMUIJZGTI7IV08OAEIMTXGA6Y9TNRYEJ"
    ) -> Self {
        [
            "grant_type":"refresh_token",
            "refresh_token": refreshToken,
            "access_type":"offline",
            "client_id": apiKey
        ]
    }
}

extension String {
    
    static let refreshTokenKey = "refreshToken"
    static let accessTokenKey = "accessToken"
    
    var withoutWhitespace: String {
        replacingOccurrences(of: "\n", with: "")
        .replacingOccurrences(of: "\r", with: "")
        .replacingOccurrences(of: "\0", with: "")
    }
    
    var localized: String {
        NSLocalizedString(
            self,
            tableName: nil,
            bundle: .main,
            value: "",
            comment: ""
        )
    }

    func localized(withComment:String = "", fileName: String?) -> String {
        NSLocalizedString(
            self,
            tableName: fileName,
            bundle: Bundle.main,
            value: "",
            comment: withComment
        )
    }
    
    var fromCredentials: String {
        localized(fileName: "Credentials")
    }
    
    func write(to path: String) {
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(path)
            do {
                try write(to: fileURL, atomically: false, encoding: .utf8)
            } catch  let err {
                print(err.localizedDescription)
            }
        }
    } 
    
    static var credentialsPath: String {
        "path".localized(fileName: "Credentials")
    }
}

extension Dictionary where Key == String, Value == String {
    var stringFile: String {
        map { "\"" + $0.0  + "\" = \"" +  $0.1 + "\";" }.joined(separator: "\n")
    }
    
    ///init a credentials dictionary for the .strings file.
    init(accessToken: String, refreshToken: String, path: String = .credentialsPath) {
        self.init()
        self["accessToken"] = accessToken
        self["refreshToken"] = refreshToken
        self["path"] = path
    }
    
    static var defaultHeader: Self {
        ["Content-Type": "application/x-www-form-urlencoded"]
    }
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}


extension String {
    
    ///  We opted for Alamo fire because we couldn't anticipate all the conversions.
    var urlEncoded: String? {
        replacingOccurrences(of: "+", with: "%2B").replacingOccurrences(of: "=", with: "%3D").replacingOccurrences(of: "/", with: "%2F")
       // addingPercentEncoding(withAllowedCharacters: .)
    }
}
/*
 
 let dictionary = ["aKey": "aValue", "anotherKey": "anotherValue"]
if let theJSONData = try? JSONSerialization.data(
    withJSONObject: dictionary,
    options: []) {
    let theJSONText = String(data: theJSONData,
                               encoding: .ascii)
    print("JSON string = \(theJSONText!)")
}
 */

func readStringFromURL(stringURL: String) -> String! {
    if let url = URL(string: stringURL) {
        do {
            return try String(contentsOf: url)
        } catch {
            print("cannot load contents")
            return nil
        }
    } else {
        print("String was not a URL")
        return nil
    }
}

extension String {
    
    var stringFromURL: String? {
        if let url = URL(string: self) {
            do {
                return try String(contentsOf: url)
            } catch {
                print("cannot load contents")
                return nil
            }
        } else {
            print("String was not a URL")
            return nil
        }
    }
    
    var rows: [[String]] {
        components(separatedBy: "\n").map {
            $0.components(separatedBy: ",")
        }
    }
    
    var columns: [[String]] {
        guard let counter = rows.first?.count else { return [] }
        return (0..<counter).map { indx in
            print(counter)
            return rows.compactMap {
                if indx >= $0.count {
                    print(indx, $0)
                    print(indx, $0)
                    return nil
                }
                return $0[indx]
            }
        }
    }
    
    var tickDescs: [TickDesc] {
        rows.compactMap {
            guard $0.count > 1 else { return nil }
            return TickDesc(ticker: $0[0], description: $0[1].replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\"", with: ""))
        }
    }
    
    var asEnum: String {
        tickDescs.map {
            "case " + $0.ticker + " = \"" + $0.description + "\""
        }.joined(separator: "\n")
    }
    
    var asSimpleEnum: String {
        tickDescs.map {
            $0.ticker
        }.joined(separator: ", ")
    }
    
    struct TickDesc {
        var ticker: String
        var description: String
    }
}



extension Array where Element == String  {
    
    static var tickers: [String] {
        "tickers".localized(fileName: "Ticker").components(separatedBy: ", ")
    }
}
