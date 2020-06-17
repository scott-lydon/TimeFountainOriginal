//
//  UserPrincipalsTest.swift
//  TimeFountainTests
//
//  Created by Scott Lydon on 6/11/20.
//  Copyright © 2020 Scott Lydon. All rights reserved.
//

import Foundation
import XCTest
@testable import TimeFountain
import Alamofire

extension TimeFountainTests {
    
    func testUserPrincipals() {
        let userPrincipalExp = expectation(description: "user Principals")
        URL.userPrincipals { principals in
            guard let principals = principals,
                let lastLogin = principals.lastLoginTimeDate else { return }
            XCTAssert(Calendar.current.isDate(lastLogin, inSameDayAs: Date()))
            userPrincipalExp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
