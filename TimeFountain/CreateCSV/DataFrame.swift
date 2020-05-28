//
//  DataFrame.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct DataFrame: Equatable {
    
    static func == (lhs: DataFrame, rhs: DataFrame) -> Bool {
        return lhs.columns == rhs.columns
    }
    
    struct Column: Equatable {
        static func == (lhs: DataFrame.Column, rhs: DataFrame.Column) -> Bool {
            return lhs.header == rhs.header && lhs.cells == rhs.cells
        }
        var header: String
        var cells: [String]
    }
    
    var columns: [Column]
    
    init?(_ columns: [Column]) {
        guard columns.map({ $0.cells.count }).allEqual, columns.count > 0 else { return nil }
        self.columns = columns
    }
    
    @discardableResult
    func convertToCSV(
        root: FileManager.SearchPathDirectory = .desktopDirectory,
        generalPath: String = "/iOS/DataFrame/",
        subPathSlashesBetween: String,
        named csvname: String = Date().description
    ) -> String {
        let postPath = generalPath + subPathSlashesBetween + "/" + csvname + ".csv"
        stringMatrix.asCSV.save(root: root, pathStr: postPath)
        return postPath
    }
    
    var stringMatrix: [[String]] {
        guard let height = columns.first?.cells.count else {
            print("cells are empty")
            return []
        }
        var rows: [[String]] = [
            columns.map({ $0.header }),
        ]
        for row in 0..<height {
            var rowArr: [String] = []
            for col in 0..<columns.count {
                rowArr.append(columns[col].cells[row].description)
            }
            rows.append(rowArr)
        }
        return rows
    }
}
