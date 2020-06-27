//
//  MACDIndicator.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation



///General Usage:
///1. Line Intersection [Reversals]
///    1. When the two MACD lines intersect with upswing, it is an indicator that the stock price will reverse up.
///    2. When the two MACD lines intersect with downswing, it is an indicator that the stock will reverse down.
///2. Arrows
///    1. Green Up Arrow indicates a potential good buy.
///    2. Red Down Arrow indicates a potential time to sell.
enum MACDIntersection: String {
    
    /// ends on negative, downtrend
    case negNegNeg
    case negNegZero
    /// ends on positive, uptrend
    case negNegPos
    /// ends on negative, downtrend
    case negZeroNeg
    case negZeroZero
    /// ends on positive, uptrend
    case negZeroPos
    /// ends on negative, downtrend
    case negPosNeg
    case negPosZero
    /// ends on positive, uptrend
    case negPosPos
    
    /// ends on negative, downtrend
    case PosNegNeg
    case PosNegZero
    /// ends on positive, uptrend
    case PosNegPos
    /// ends on negative, downtrend
    case PosZeroNeg
    case PosZeroZero
    /// ends on positive, uptrend
    case PosZeroPos
    /// ends on negative, downtrend
    case PosPosNeg
    case PosPosZero
    /// ends on positive, uptrend
    case PosPosPos
    
    /// ends on negative, downtrend
    case zeroNegNeg
    case zeroNegZero
    /// ends on positive, uptrend
    case zeroNegPos
    /// ends on negative, downtrend
    case zeroZeroNeg
    case zeroZeroZero
    /// ends on positive, uptrend
    case zeroZeroPos
    /// ends on negative, downtrend
    case zeroPosNeg
    case zeroPosZero
    /// ends on positive, uptrend
    case zeroPosPos
    
    ///General Usage:
    ///1. Line Intersection [Reversals]
    ///    1. When the two MACD lines intersect with upswing, it is an indicator that the stock price will reverse up.
    ///    2. When the two MACD lines intersect with downswing, it is an indicator that the stock will reverse down.
    /// 2. Arrows
    ///    1. Green Up Arrow indicates a potential good buy.
    ///    2. Red Down Arrow indicates a potential time to sell.
    ///
    /// Note: It might not appear as though diffs represent crosses, however, when one diff is positive and the next diff is negative that indicates a cross in the lines, and the inverse.
    init(_ diff1: Double, _ diff2: Double, _ diff3: Double) {
        self.init(diff1.mag, diff2.mag, diff3.mag)
    }
    
    ///General Usage:
    ///1. Line Intersection [Reversals]
    ///    1. When the two MACD lines intersect with upswing, it is an indicator that the stock price will reverse up.
    ///    2. When the two MACD lines intersect with downswing, it is an indicator that the stock will reverse down.
    /// 2. Arrows
    ///    1. Green Up Arrow indicates a potential good buy.
    ///    2. Red Down Arrow indicates a potential time to sell.
    ///
    /// Note: It might not appear as though diffs represent crosses, however, when one diff is positive and the next diff is negative that indicates a cross in the lines, and the inverse.
    init(_ mag1: Double.Magnitudey, _ mag2: Double.Magnitudey, _ mag3: Double.Magnitudey) {
        switch (mag1, mag2, mag3) {
        case (.negative, .negative, .negative): self = .negNegNeg
        case (.negative, .negative, .zero): self = .negNegZero
        case (.negative, .negative, .positive): self = .negNegPos
        case (.negative, .zero, .negative): self = .negZeroNeg
        case (.negative, .zero, .zero): self = .negZeroZero
        case (.negative, .zero, .positive): self = .negZeroPos
        case (.negative, .positive, .negative): self = .negPosNeg
        case (.negative, .positive, .zero): self = .negPosZero
        case (.negative, .positive, .positive): self = .negPosPos
        case (.positive, .negative, .negative): self = .PosNegNeg
        case (.positive, .negative, .zero): self = .PosNegZero
        case (.positive, .negative, .positive): self = .PosNegPos
        case (.positive, .zero, .negative): self = .PosZeroNeg
        case (.positive, .zero, .zero): self = .PosZeroZero
        case (.positive, .zero, .positive): self = .PosZeroPos
        case (.positive, .positive, .negative): self = .PosPosNeg
        case (.positive, .positive, .zero): self = .PosPosZero
        case (.positive, .positive, .positive): self = .PosPosPos
        case (.zero, .negative, .negative): self = .zeroNegNeg
        case (.zero, .negative, .zero): self = .zeroNegZero
        case (.zero, .negative, .positive): self = .zeroNegPos
        case (.zero, .zero, .negative): self = .zeroZeroNeg
        case (.zero, .zero, .zero): self = .zeroZeroZero
        case (.zero, .zero, .positive): self = .zeroZeroPos
        case (.zero, .positive, .negative): self = .zeroPosNeg
        case (.zero, .positive, .zero): self = .zeroPosZero
        case (.zero, .positive, .positive): self = .zeroPosPos
        }
    }
}

extension Double {
    enum Magnitudey {
        case negative, zero, positive
        
        init(compare first: Double, to second: Double) {
            if first > second {
                self = .positive
            } else if first < second {
                self = .negative
            } else {
                self = .zero
            }
        }
    }
    
    var mag: Magnitudey {
        if self > 0 {
            return .positive
        } else if self < 0 {
            return .negative
        } else {
            return .zero
        }
    }
}

enum MACDBarsIndicator {
    case greenFlatline
    case redflatline
    case returned
    case greenUturn
}

extension Array where Element == Double {
    ///General Usage:
    ///1. Line Intersection [Reversals]
    ///    1. When the two MACD lines intersect with upswing, it is an indicator that the stock price will reverse up.
    ///    2. When the two MACD lines intersect with downswing, it is an indicator that the stock will reverse down.
    func macdIndicators(
        fast: Int = 12,
        slow: Int = 26,
        length: Int = 9,
        smoothing: Int = 2
    ) -> [MACDIntersection?] {
        [nil, nil] + macdDiffs(fast: fast, slow: slow, length: length, smoothing: smoothing).mapThree { diff1, diff2, diff3 in
            guard let dif1 = diff1, let dif2 = diff2, let dif3 = diff3 else { return nil }
            return MACDIntersection(dif1, dif2, dif3)
        }
    }
}
