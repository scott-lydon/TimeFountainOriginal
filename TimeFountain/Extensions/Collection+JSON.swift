//
//  Collection+JSON.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/7/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Collection {
    
    func json(encoding: String.Encoding, options: JSONSerialization.WritingOptions) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
            guard let jsonString = String(data: jsonData, encoding: encoding) else {
                print("Error: Can't create string with data. line: \(#line), file: \(#file)")
                return "{}"
            }
            return jsonString
        } catch let parseError {
            print("Error: json serialization error: \(parseError)")
            return nil
        }
    }
    
    var tdJSON: String {
        if let json = json(encoding: .utf8, options: [])  {
            return json
        }
        print("ERROR: Failed to parse the JSON")
        return ""
    }
}

extension Encodable {
    
    var tdJSON: String {
        dictionary.tdJSON
    }
}
