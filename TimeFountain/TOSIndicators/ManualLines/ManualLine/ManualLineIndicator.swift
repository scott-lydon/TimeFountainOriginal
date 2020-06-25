//
//  ManualLineEntryIndicator.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/24/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension ManualLine {
    
    typealias Bolinger = ClosedRange<Double>
    
    /// Specific for manual lilnes, because
    /// Needs a revamp because there can be multiple lines.
    /// This is a primitive component.
    /// The associated Int represents the number of confirmations of the line.
    enum Indicator {
        case FarAboveResistance(Int)
        case justAboveResistance(Int)
        case onResistance(Int)
        case justUnderResistance(Int)
        case farUnderResistance(Int)
        case farAboveSupport(Int)
        case justAboveSupport(Int)
        case onSupport(Int)
        case justUnderSupport(Int)
        case farUnderSupport(Int)
        
        var confirmationCount: Int {
            switch self {
            case .FarAboveResistance(let count):
               return count
            case .justAboveResistance(let count):
                return count
            case .onResistance(let count):
                return count
            case .justUnderResistance(let count):
                return count
            case .farUnderResistance(let count):
                return count
            case .farAboveSupport(let count):
                return count
            case .justAboveSupport(let count):
                return count
            case .onSupport(let count):
                return count
            case .justUnderSupport(let count):
                return count
            case .farUnderSupport(let count):
                return count
            }
        }
        
        var name: String {
            switch self {
            case .FarAboveResistance(let count):
               return "FarAboveResistance\(count)"
            case .justAboveResistance(let count):
                return "justAboveResistance\(count)"
            case .onResistance(let count):
                return "onResistance\(count)"
            case .justUnderResistance(let count):
                return "justUnderResistance\(count)"
            case .farUnderResistance(let count):
                return "farUnderResistance\(count)"
            case .farAboveSupport(let count):
                return "farAboveSupport\(count)"
            case .justAboveSupport(let count):
                return "justAboveSupport\(count)"
            case .onSupport(let count):
                return "onSupport\(count)"
            case .justUnderSupport(let count):
                return "justUnderSupport\(count)"
            case .farUnderSupport(let count):
                return "justUnderSupport\(count)"
            }
        }
        
        var trend: Trend {
            switch self {
            case .FarAboveResistance:
                return .level
            case .justAboveResistance:
                return .up
            case .onResistance:
                return .level
            case .justUnderResistance:
                return .down
            case .farUnderResistance:
                return .level
            case .farAboveSupport:
                return .level
            case .justAboveSupport:
                return .up
            case .onSupport:
                return .level
            case .justUnderSupport:
                return .down
            case .farUnderSupport:
                return .level
            }
        }
        
        init(_ manualLines: ManualLines) {
            // TODO
            self = .FarAboveResistance(10)
        }
        
        
//        init(close: Double, manualLine: ManualLine, bolinger: Bolinger) {
////            if close < manualLine.value {
////
////            } else if close > manualLine.value {
////
////            } else {
////
////            }
//        }
    }
}

