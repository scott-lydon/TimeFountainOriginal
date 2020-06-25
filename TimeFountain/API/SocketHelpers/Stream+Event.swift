//
//  Stream+Event.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/4/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension Stream.Event {
  var message: String {
    switch self {
    case .hasBytesAvailable:
      return "new message received"
    case .endEncountered:
      return "new message received"
    case .errorOccurred:
      return "error occurred"
    case .hasSpaceAvailable:
      return "has space available"
    default:
      return "some other event..."
    }
  }
}
