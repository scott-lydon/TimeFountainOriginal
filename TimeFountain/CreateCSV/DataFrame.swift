//
//  DataFrame.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

struct DataFrame {
    
    struct Column {
        var header: String
        var cells: [CSVRepresentable]
    }
    
    var columns: [Column]
    
    init?(_ columns: [Column]) {
        guard columns.map({ $0.cells.count }).allEqual else { return nil }
        self.columns = columns
    }
    
    func convertToCSV(
        root: FileManager.SearchPathDirectory = .desktopDirectory,
        path: String = "/iOS/DataFrame",
        name: String = Date().description
    ) {
        asCSVString.save(root: root, pathStr: path + name + ".csv")
    }
    
    var asCSVString: String {
        return ""
    }
}

extension String {
    func save(root: FileManager.SearchPathDirectory, pathStr: String) {
        print("WTF", #line)
        let fileManager = FileManager.default
        do {
            let path = try fileManager.url(
                for: root,
                in: .allDomainsMask,
                appropriateFor: nil,
                create: true
            )
            let fileURL = path.appendingPathComponent(pathStr)
            try write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("error creating file")
        }
    }
}



func createCSV(from recArray:[Dictionary<String, Any>]) {
    var csvString = "\("Employee ID"),\("Employee Name")\n\n"
    for dct in recArray {
        csvString = csvString.appending("\(String(describing: dct["EmpID"]!)) ,\(String(describing: dct["EmpName"]!))\n")
    }

}

