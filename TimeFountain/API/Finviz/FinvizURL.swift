//
//  FinvizURL.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/7/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension URL {
    
    static var finviz: URL {
        URL(string: "https://finviz.com/screener.ashx?v=111&f=sh_avgvol_u500,sh_curvol_o400,sh_price_u10,ta_change_u9,ta_gap_u,ta_rsi_nob60&ft=4")!
    }
    
    typealias StringsAction = ([String]) -> Void
    
    static func finviz(stringAction: @escaping StringsAction) {
        URL.finviz.getData { data in
            guard let content = String(
                data: data,
                encoding: .ascii
                ) else { return }
            let before = "class=\"screener-link-primary\">"
            let after = "</a></td>"
            return stringAction(content.matches(for: before + "(.*?)" + after))
        }
    }
}

extension String {
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(
                in: self,
                range: NSRange(startIndex..., in: self)
            )
            return results.map {
                String(self[Range($0.range(at: 1), in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
