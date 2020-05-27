//
//  CommaSeparatedArraytests.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 5/27/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain

struct CommaSepInputOutput {
    var input: [String]
    var output: String
}

fileprivate let csvInputOutputs: [CommaSepInputOutput] = [
    CommaSepInputOutput(input: ["cat", "dog", "labs"], output: "cat,dog,labs\n"),
    CommaSepInputOutput(input: [""], output: "\n"),
    CommaSepInputOutput(input: ["human", "window"], output: "human,window\n"),
]


extension TimeFountainTests {
    
    func testCommaSeparatedArr() {
        csvInputOutputs.forEach {
            let commasep = $0.input.commaSeparatedNewLine
            XCTAssert(commasep == $0.output, "Failure with input array: \($0.input), and result: \(commasep) was not: \($0.output)")
        }
    }
}

