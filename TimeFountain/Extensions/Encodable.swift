//
//  Encodable.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/2/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any] {
        do {
            return try toDictionary()
        } catch let err {
            print(#line, "Error was: ", err)
            return [:]
        }
    }
    
    /// Converting object to postable dictionary
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }
    
    var stringified: String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Dictionary where Key == String, Value == Any {
    var stringified: String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            guard let stringy = String(data: data, encoding: .utf8) else {
                print("ERROR: failed to cast data as string")
                return nil
            }
            return stringy
        } catch let err {
            print("error with " + #function + ": " + err.localizedDescription)
            return nil
        }
    }
}
