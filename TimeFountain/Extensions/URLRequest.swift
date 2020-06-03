//
//  URLRequest.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/1/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URLRequest {
    
    enum HTTPMethod: String {
        case GET, POST
        
        init?(_ str: String?) {
            guard let str = str,
                let method = HTTPMethod(rawValue: str) else { return nil }
            self = method
        }
        
        init(_ hasHeaders: Bool) {
            self = hasHeaders ? .POST : .GET
        }
    }
    
    var method: HTTPMethod? {
        get {
            return HTTPMethod(httpMethod)
        }
        set {
            httpMethod = newValue?.rawValue
        }
    }
    
    init(url: URL, headers: [String: String], method: HTTPMethod = .POST) {
        self = URLRequest(url: url)
        self.method = method
        self.allHTTPHeaderFields = headers
    }

}


extension Dictionary where Key == String, Value == String {
    static func forAccess(_ token: String) -> Self {
        ["Authorization": "Bearer " + token]
    }
    
    static var allowHeader: Self {
        ["Allow": "GET, PUT, POST, DELETE"]
    }
}
