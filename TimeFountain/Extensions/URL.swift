//
//  URL.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

typealias DataAction = (Data) -> Void

extension URL {
    
    func getData(_ dataAction: DataAction? = nil) {
        sessionDataTask(provideData: dataAction)?.resume()
    }
    
    func sessionDataTask(provideData: DataAction?) -> URLSessionDataTask? {

        return URLSession.shared.dataTask(with: self) {
            data, response, error in
            guard let data = data else {
                print("ERROR: data was nil for the call from: \(self), ")
                return
            }
            provideData?(data)
        }
    }
}
