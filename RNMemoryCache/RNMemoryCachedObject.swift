//
//  RNMemoryCachedObject.swift
//  RNMemoryCache
//
//  Created by mothule on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation

class RNMemoryCachedObject {
    private var target: Any? {
        didSet {
            updatedAt = Date()
        }
    }
    private var value: Any? {
        set {
            target = newValue
        }
        get {
            return isExpired ? nil : target
        }
    }
    private var updatedAt: Date = Date()
    private var expireTime: TimeInterval?

    init(value: Any?, expireTime: TimeInterval? = nil) {
        self.value = value
        self.expireTime = expireTime
    }
    init(expireTime: TimeInterval? = nil) {
        self.expireTime = expireTime
        expire()
    }

    private var expireDate: Date? {
        guard let expireTime = expireTime else { return nil }
        return updatedAt.addingTimeInterval(expireTime)
    }

    private var isExpired: Bool {
        guard let expireDate = expireDate else { return false }
        return Date() > expireDate
    }

    private func expire() {
        guard let expireTime = expireTime else { return }
        updatedAt = Date().addingTimeInterval(-expireTime)
    }

    func invalidate() {
        value = nil
        expire()
    }

    func get<T>() -> T? {
        return value as? T
    }

    func set(_ value: Any?, expireTime: TimeInterval? = nil) {
        self.value = value
        self.expireTime = expireTime
    }
    func set(expireTime: TimeInterval? = nil) {
        self.expireTime = expireTime
    }
}

extension RNMemoryCachedObject: CustomDebugStringConvertible {
    var debugDescription: String {
        let valueString = "\(value != nil ? value! : "nil")"
        let targetString = "\(target != nil ? target! : "nil")"
        let expireTimeString = "\(expireTime != nil ? "\(expireTime!)" : "infinity")"
        return "{value: \(valueString), target: \(targetString) updatedAt: \(updatedAt), expireTime: \(expireTimeString)}"
    }
}
