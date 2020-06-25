//
//  OutputStream.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/4/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension OutputStream {
  
  func send(message: String) {
    guard let data = message.data(using: .utf8) else {
      print("could not convert string to data")
      return
    }
    _ = data.withUnsafeBytes {
      guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
        print("Error joining chat")
        return
      }
      write(pointer, maxLength: data.count)
    }
  }
}
