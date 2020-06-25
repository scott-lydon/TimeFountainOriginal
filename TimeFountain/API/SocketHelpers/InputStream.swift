//
//  InputStream.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/4/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

extension InputStream {
  
  func readFreeBytes(maxReadLength: Int, thisUserName: String, messageAction: MessageAction) {
    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
    while hasBytesAvailable {
      let numberOfBytesRead = read(buffer, maxLength: maxReadLength)
      if numberOfBytesRead < 0,
        let error = streamError {
        print(error)
        break
      }
      if let message = Message(
        buffer: buffer,
        length: numberOfBytesRead,
        thisUserName: thisUserName
        ) {
        messageAction(message)
      }
    }
  }
}
