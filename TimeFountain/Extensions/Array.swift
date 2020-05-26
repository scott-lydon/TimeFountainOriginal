//
//  Array.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array {
    func enumerate<Ret>(action: (Int, Element)->Ret) -> [Ret] {
        var returnValues: [Ret] = []
        for (index, element) in enumerated() {
            returnValues.append(action(index, element))
        }
        return returnValues
    }
}
