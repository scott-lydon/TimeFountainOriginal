//
//  TDIteration.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/11/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    typealias IntAction = (Int) -> Void
    
    ///TD Ameritrade allows 120 calls a minute
    /// This makes a call every 0.6 seconds in case other api calls are running concurrently.
    static func tdAPI(
        repeats: Int,
        repeatedAction: @escaping IntAction
    ) {
        (0...(repeats - 1)).forEach { int in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                repeatedAction(int)
            }
        }
    }
}
