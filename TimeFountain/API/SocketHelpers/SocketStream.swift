//
//  Stream.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/4/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Stream {
  func openConnection() {
    schedule(in: .current, forMode: .common)
    open()
  }
}
