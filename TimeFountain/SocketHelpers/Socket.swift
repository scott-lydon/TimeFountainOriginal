//
//  Socket.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/4/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

class Socket: NSObject, StreamDelegate {
  
  var inputStream: InputStream!
  var outputStream: OutputStream!
  var maxReadLength: Int = 4096
  var thisUserName: String = ""
  /// Only need to set this property.  It is accessed when the sockets call back through delegation.
  var messageAction: MessageAction?
  
  // initiate setup.
  func setupNetworkCommunication(
    address: String = "localhost",
    port: UInt32 = 80
  ) {
    var readStream: Unmanaged<CFReadStream>?
    var writeStream: Unmanaged<CFWriteStream>?
    CFStreamCreatePairWithSocketToHost(
      kCFAllocatorDefault,
      address as CFString,
      port,
      &readStream,
      &writeStream
    )
    inputStream = readStream!.takeRetainedValue()
    outputStream = writeStream!.takeRetainedValue()
    inputStream.delegate = self
    inputStream.openConnection()
    outputStream.openConnection()
  }
  
  /// Outgoing messaging
  func joinChat(username: String = "") {
    outputStream.send(message: "iam" + username)
  }
  
  /// Outgoing messaging
  func send(subscripting: String = "msg", message: String) {
    outputStream.send(message: subscripting + message)
  }
  
  /// Inncoming messages, from StreamDelegate delegation
  // func stream(_ aStream: Stream, handle eventCode: Stream.Event)
  func stream(
    _ aStream: Stream,
    handle eventCode: Stream.Event
  ) {
    print(eventCode.message)
    if case .hasBytesAvailable = eventCode {
      (aStream as? InputStream)?.readFreeBytes(
        maxReadLength: maxReadLength,
        thisUserName: thisUserName
      ) { message in
        messageAction?(message)
      }
    } else if case .endEncountered = eventCode {
      closeSession()
    }
  }
  
  /// Close stream
  func closeSession() {
    inputStream?.close()
    outputStream?.close()
  }
}
