//
//  String+matrix.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/27/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Array where Element == [String] {
    var asCSV: String {
        var str = self.map({ $0.commaSeparatedNewLine }).joined()
        str.removeLast()
        //str.removeLast()
        
        return str
    }
}

extension Array where Element == String {
    var commaSeparatedNewLine: String {
        return self.joined(separator: ",") + "\n"
    }
}
