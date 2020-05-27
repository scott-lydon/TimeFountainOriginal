//
//  CSVTests.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 5/27/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain

fileprivate var csvStrings: [DataFrameInputOutput.CSVString] = [
    DataFrameInputOutput.CSVString(
        matrix: [
            ["Header"],
            ["cow"],
            ["cat"],
            ["dog"],
        ],
        string: "Header\ncow\ncat\ndog"
    ),
    DataFrameInputOutput.CSVString(
        matrix: [
            ["Column1", "Column2"],
            ["cow", "row1"],
            ["cat", "row2"],
            ["dog", "row3"],
        ],
        string: "Column1,Column2\ncow,row1\ncat,row2\ndog,row3"
    ),
    DataFrameInputOutput.CSVString(
        matrix: [
            ["Column1", "Column2", "Column3"],
            ["cow", "row1", "row1Col3"],
            ["cat", "row2", "row2Col3"],
        ],
        string: "Column1,Column2,Column3\ncow,row1,row1Col3\ncat,row2,row2Col3"
    ),
]

extension TimeFountainTests {
    func testCSVString() {
        csvStrings.forEach {
            let csvString = $0.matrix.asCSV
            XCTAssert(
                csvString == $0.string,
                "\n\nFailed for input matrix: \n\($0.matrix), result was: \(csvString), should have been: \($0.string)\n\n"
            )
        }
    }
}

/*

extension Array where Element == [String] {
    var asCSV: String {
        var str = self.map({ $0.commaSeparatedNewLine }).joined()
        str.removeLast()
        str.removeLast()
        return str
    }
}


*/
