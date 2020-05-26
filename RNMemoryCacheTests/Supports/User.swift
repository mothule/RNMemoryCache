//
//  User.swift
//  RNMemoryCacheTests
//
//  Created by mothule on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation

struct User: Equatable {
    let firstName: String
    let lastName: String
    init(first: String, last: String) {
        firstName = first
        lastName = last
    }
    
    static var empty: User {
        .init(first: "", last: "")
    }
    
    static var sample: User {
        let first = "First\(Int.random(in: 1..<Int.max))"
        let last = "Last\(Int.random(in: 1..<Int.max))"
        return .init(first: first, last: last)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName
    }
}
