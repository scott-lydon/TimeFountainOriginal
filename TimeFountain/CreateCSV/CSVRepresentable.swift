//
//  CSVRepresentable.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/26/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

protocol CSVRepresentable {
    var description: String { get }
}

extension Int: CSVRepresentable {}
extension Double: CSVRepresentable {}
extension String: CSVRepresentable {}
