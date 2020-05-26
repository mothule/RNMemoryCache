//
//  RNStandaloneCache.swift
//  RNMemoryCache
//
//  Created by mothule on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation

public struct RNStandaloneCache<E> {
    public typealias Element = E

    private var _value: Element?
    private var lastRefreshedTime: Date
    private let expirationTimeInterval: TimeInterval

    public var value: Element? {
        get {
            guard !isExpired else { return nil }
            return _value
        }

        set {
            if let newValue = newValue {
                _value = newValue
                lastRefreshedTime = Date()
            } else {
                _value = nil
                expire()
            }
        }
    }

    public var isExpired: Bool {
        Date().timeIntervalSince(lastRefreshedTime) >= expirationTimeInterval
    }

    public init(initial: Element?, interval: TimeInterval) {
        self.expirationTimeInterval = interval
        self.lastRefreshedTime = Date()
        self._value = initial
    }

    public func valueOr(_ default: Element) -> Element { value ?? `default` }
    
    public mutating func expire() {
        lastRefreshedTime = Date(timeIntervalSince1970: 0)
    }
}
