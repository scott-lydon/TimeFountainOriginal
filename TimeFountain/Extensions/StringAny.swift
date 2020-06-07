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
}

extension String {
    
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
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}


extension String {
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
