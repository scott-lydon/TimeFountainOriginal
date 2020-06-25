//
//  CandleShapeIndicators.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/22/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Candle {
    
    
    var shape: Shape {
        Shape(self)
    }

    enum PosZero {
        case positive(Double), zero
        
        init(_ first: Double, _ second: Double) {
            self = (first == second) ? .zero : .positive(abs(first - second))
        }
    }
        
    /// These letters represnt the highest to lowest value going from left to right.
    /// An underscore indicates equality.
    
    /// The Ls correspond to the gaps between prices.
    /// oc means open is higher than close
    /// co means open is lower than close
    /// _ _ _
    /// first represents the gap between the open and the low if going down, high if going up.
    /// second represents the gap between the high and low
    /// third represents the gap between the high and close
    /// There are 27 candle shapes
    enum Shape: String {
        
        case down_noWhick_bigBody_smallShadow
        case down_noWhick_smallBody_bigShadow
        case down_smallWhick_BigBody_NoShadow
        case down_bigWhick_SmallBody_noShadow
        case down_FlatWhick_FlatShadow
        
        case up_flatWhick_bigBody_smallShadow
        case up_flatWhick_smallBody_bigShadow
        case up_smallWhick_bigBody_flatShadow
        case up_bigWhick_smallBody_flatShadow
        case up_flatWhick_NoShadow
        
        case flatLine_BigWhick_smallShadow
        case flatLine_smallWhick_bigShadow
        case flatLine_withShadow
        case flatLine_withWhick
        case flatLine
        
        case up_bigWhick_medBody_smallShadow
        case up_medWhick_medBody_smallShadow
        case up_smallWhick_medBody_smallShadow
        case up_bigWhick_smallBody_medShadow
        case up_medWhick_smallBody_medShadow
        case up_smallWhick_smallBody_medShadow
        
        case down_bigWhick_medBody_smallShadow
        case down_medWhick_medBody_smallShadow
        case down_smallWhick_medBody_smallShadow
        case down_bigWhick_smallBody_medShadow
        case down_medWhick_smallBody_medShadow
        case down_smallWhick_smallBody_medShadow
        
        enum Polarity {
            case up, down
            
            init(up: Bool) {
                self = up ? .up : .down
            }
        }
        
        enum Size {
            case big, medium, small
            
            init(relationOf first: Double, to second: Double, and third: Double) {
                if second > first && first > third {
                    self = .medium
                } else if second < first && first > third {
                    self = .big
                } else {
                    self = .small
                }
            }
        }
        
        init(
            up: Bool,
            whickHeight: Double,
            bodyHeight: Double,
            shadowHeight: Double
        ) {
            let whickSize = Size(relationOf: whickHeight, to: bodyHeight, and: shadowHeight)
            let bodyBiggerThanShadow = bodyHeight > shadowHeight
            switch Polarity(up: up) {
            case .up:
                switch (whickSize, bodyBiggerThanShadow) {
                case (.big, true):
                    self = .up_bigWhick_medBody_smallShadow
                case (.medium, true):
                    self = .up_medWhick_medBody_smallShadow
                case (.small, true):
                    self = .up_smallWhick_medBody_smallShadow
                case (.big, false):
                    self = .up_bigWhick_smallBody_medShadow
                case (.medium, false):
                    self = .up_medWhick_smallBody_medShadow
                case (.small, false):
                    self = .up_smallWhick_smallBody_medShadow
                }
            case .down:
                switch (whickSize, bodyBiggerThanShadow) {
                case (.big, true):
                    self = .down_bigWhick_medBody_smallShadow
                case (.medium, true):
                    self = .down_medWhick_medBody_smallShadow
                case (.small, true):
                    self = .down_smallWhick_medBody_smallShadow
                case (.big, false):
                    self = .down_bigWhick_smallBody_medShadow
                case (.medium, false):
                    self = .down_medWhick_smallBody_medShadow
                case (.small, false):
                    self = .down_smallWhick_smallBody_medShadow
                }
            }
        }
        
        init(_ candle: Candle) {
            self.init(
                candle.candleOpen,
                high: candle.high,
                low: candle.low,
                close: candle.close
            )
        }
        
        init(
            _ open: Double,
            high: Double,
            low: Double,
            close: Double
        ) {
            let body = abs(high - low)
            if open > close { // Downward
                let whick = PosZero(open, high)
                let lowShadow = PosZero(close, low)
                switch (whick, lowShadow) {
                case (.positive(let whickHeight), .positive(let lowHeight)):
                    self.init(up: false, whickHeight: whickHeight, bodyHeight: body, shadowHeight: lowHeight)
                case (.zero, .positive(let lowHeight)):
                    self = (body > lowHeight) ? .down_noWhick_bigBody_smallShadow : .down_noWhick_smallBody_bigShadow
                case (.positive(let whickHeight), .zero):
                    self = (body > whickHeight) ? .down_smallWhick_BigBody_NoShadow : .down_bigWhick_SmallBody_noShadow
                case (.zero, .zero):
                    self = .down_FlatWhick_FlatShadow
                }
            } else if open < close { // upward
                let whick = PosZero(close, high)
                let lowShadow = PosZero(open, low)
                switch (whick, lowShadow) {
                case (.positive(let whickHeight), .positive(let lowHeight)):
                    self.init(up: true, whickHeight: whickHeight, bodyHeight: body, shadowHeight: lowHeight)
                case (.zero, .positive(let lowHeight)):
                    self = (body > lowHeight) ? .up_flatWhick_bigBody_smallShadow : .up_flatWhick_smallBody_bigShadow
                case (.positive(let whickHeight), .zero):
                    self = (body > whickHeight) ? .up_smallWhick_bigBody_flatShadow : .up_bigWhick_smallBody_flatShadow
                case (.zero, .zero):
                    self = .up_flatWhick_NoShadow
                }
            } else { // level
                let whick = PosZero(close, high)
                let lowShadow = PosZero(open, low)
                switch (whick, lowShadow) {
                case (.positive(let whickHeight), .positive(let lowHeight)):
                    self = (whickHeight > lowHeight) ? .flatLine_BigWhick_smallShadow : .flatLine_smallWhick_bigShadow
                case (.zero, .positive(_)):
                    self = .flatLine_withShadow
                case (.positive(_), .zero):
                    self = .flatLine_withWhick
                case (.zero, .zero):
                    self = .flatLine
                }
            }
        }
    }
}


extension Array where Element == Candle {
    
    /// Should include 3-4 offset columns.
    var shapes: [Candle.Shape] {
        map { $0.shape }
    }
}
