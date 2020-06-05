//
//  Message.swift
//  TimeFountain
//
//  Created by Scott Lydon on 6/4/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation


typealias MessageAction = (Message) -> Void

struct Message {
  let message: String
  let senderUsername: String
  let messageSender: MessageSender
  
  init(message: String, messageSender: MessageSender, username: String) {
    self.message = message.withoutWhitespace
    self.messageSender = messageSender
    self.senderUsername = username
  }

  init?(buffer: UnsafeMutablePointer<UInt8>, length: Int, thisUserName: String) {
    guard let stringArray = String(
      bytesNoCopy: buffer,
      length: length,
      encoding: .utf8,
      freeWhenDone: true
      )?.components(separatedBy: ":"),
      let name = stringArray.first,
      let message = stringArray.last else {
        return nil
    }
    self = Message(
      message: message,
      messageSender: name == thisUserName ? .ourself : .someoneElse,
      username: name
    )
  }
}
