//
//  Nimble+Extension.swift
//  RNMemoryCacheTests
//
//  Created by mothule on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation
import Nimble

public func bePresent<T>() -> Predicate<T> {
    return Predicate.simpleNilable("be present") { actualExpression in
        let actualValue = try actualExpression.evaluate()
        return PredicateStatus(bool: actualValue != nil)
    }
}


#if canImport(Darwin)
import Foundation

extension NMBPredicate {
    @objc public class func bePresentMatcher() -> NMBPredicate {
        return NMBPredicate { actualExpression in
            return try bePresent().satisfies(actualExpression).toObjectiveC()
        }
    }
}
#endif
