//
//  Account.swift
//  TimeFountain
//
//  Created by Scott Lydon on 5/21/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation

// MARK: - GeneralAccountCall
struct GeneralAccount<T: Accountable>: Codable {
    let securitiesAccount: T
}

protocol Accountable: Codable {}

///OrderActivity see:  Execution, ExecutionLeg done.

