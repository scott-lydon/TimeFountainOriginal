//
//  StringMatrixTests.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 5/27/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain

fileprivate var stringMatrices: [DataFrameInputOutput.StringMatrix] = [
    DataFrameInputOutput.StringMatrix(
        dataFrame: DataFrame(
            DataFrame.Column(header: "Header", cells: ["cow", "cat", "dog"])
            )!,
        matrix: [
            ["Header"],
            ["cow"],
            ["cat"],
            ["dog"],
        ]
    ),
    DataFrameInputOutput.StringMatrix(
        dataFrame: DataFrame(
            DataFrame.Column(header: "Column1", cells: ["cow", "cat", "dog"]),
            DataFrame.Column(header: "Column2", cells: ["row1", "row2", "row3"])
            )!,
        matrix: [
            ["Column1", "Column2"],
            ["cow", "row1"],
            ["cat", "row2"],
            ["dog", "row3"],
        ]
    ),
    DataFrameInputOutput.StringMatrix(
        dataFrame: DataFrame([
            DataFrame.Column(header: "Column1", cells: ["cow", "cat"]),
            DataFrame.Column(header: "Column2", cells: ["row1", "row2"]),
            DataFrame.Column(header: "Column3", cells: ["row1Col3", "row2Col3"]),
        ])!,
        matrix: [
            ["Column1", "Column2", "Column3"],
            ["cow", "row1", "row1Col3"],
            ["cat", "row2", "row2Col3"],
        ]
    ),
]

extension TimeFountainTests {
    func testStringMatrices() {
        stringMatrices.forEach {
            let testMatrix = $0.dataFrame.stringMatrix
            XCTAssert(
                testMatrix == $0.matrix,
                "\n\n\nFailed for input dataframe: \n\($0.dataFrame), \nresult was \n\(testMatrix), \nshould have been \n\($0.matrix)"
            )
        }
    }
}

/*
 
 var stringMatrix: [[String]] {
     guard let height = columns.first?.cells.count else {
         print("cells are empty")
         return []
     }
     var rows: [[String]] = []
     for hindex in 0..<height {
         rows.append([])
         for index in 0..<columns.count {
             let cell = columns[index].cells[hindex].description
             rows[hindex].append(cell)
         }
     }
     return rows
 }
 
 */
