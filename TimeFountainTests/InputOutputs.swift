//
//  InputOutputs.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 5/25/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct InputOutput<Input, Output> {
    var input: Input
    var output: Output
}

struct Input2Output<Input, Input2, Output> {
    var input: Input
    var input2: Input2
    var output: Output
}

struct Input3Output<Input, Input2, Input3, Output> {
    var input: Input
    var input2: Input2
    var input3: Input3
    var output: Output
}

struct Input4Output<Input, Input2, Input3, Input4, Output> {
    var input: Input
    var input2: Input2
    var input3: Input3
    var input4: Input4
    var output: Output
}
