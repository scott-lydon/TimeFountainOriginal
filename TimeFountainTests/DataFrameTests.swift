//
//  DataFrameTests.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 5/27/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain

struct DataFrameInputOutput {
    var columns: [DataFrame.Column]
    var output: DataFrame?
    
    struct StringMatrix {
        var dataFrame: DataFrame
        var matrix: [[String]]
    }
    
    struct CSVString {
        var matrix: [[String]]
        var string: String
    }
}

fileprivate var dfInputOutputs: [DataFrameInputOutput] = [
    DataFrameInputOutput(
        columns: [
            DataFrame.Column(
                header: "Date",
                cells: ["39434934", "340999234"]
            ),
            DataFrame.Column(
                header: "TryThis",
                cells: ["Cat"]
            )
        ],
        output: nil
    ),
    DataFrameInputOutput(
        columns: [
            DataFrame.Column(
                header: "Date",
                cells: ["39434934", "340999234"]
            ),
            DataFrame.Column(
                header: "TryThis",
                cells: ["Cat", "Dog"]
            )
        ],
        output: DataFrame([
            DataFrame.Column(
                header: "Date",
                cells: ["39434934", "340999234"]
            ),
            DataFrame.Column(
                header: "TryThis",
                cells: ["Cat", "Dog"]
            )
        ])
    ),
]



//var dfInputOutputs
extension TimeFountainTests {
    
    func testDataFrame() {
        dfInputOutputs.forEach {
            let df = DataFrame($0.columns)
            XCTAssert(df == $0.output, "Failed for input columns: \($0.columns), result was dataframe: \(String(describing: df)), should have been \(String(describing: $0.output))")
        }
    }
}








/*
 struct Column {
      var header: String
      var cells: [CSVRepresentable]
  }
  
  var columns: [Column]
  
  init?(_ columns: [Column]) {
      guard columns.map({ $0.cells.count }).allEqual, columns.count > 0 else { return nil }
      self.columns = columns
  }
  
  func convertToCSV(
      root: FileManager.SearchPathDirectory = .desktopDirectory,
      path: String = "/iOS/DataFrame",
      name: String = Date().description
  ) {
      asCSVString.save(root: root, pathStr: path + name + ".csv")
  }
  
  
  func itterateAllRows(action: StringAction) {
      let columnCount = columns.count
      for index in 0..<columnCount {
          action(columns[index].header)
      }
      guard let height = columns.first?.cells.count else {
          print("cells are empty")
          return
      }
      for hindex in 0..<height {
          for index in 0..<columnCount {
              action(columns[index].cells[hindex].description)
          }
      }
  }
  
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
  
  
  var asCSVString: String {
      var str = ""
      for row in stringMatrix {
          str += row.joined(separator: ",") + ";/n"
      }
      return str
  }
 */



