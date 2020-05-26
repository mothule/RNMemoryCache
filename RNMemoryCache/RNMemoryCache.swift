//
//  RNMemoryCache.swift
//  RNMemoryCache
//
//  Created by mothule on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation

public class RNMemoryCache {
    public static var shared: RNMemoryCache = RNMemoryCache()

    private var cachedObjects: [AnyHashable: RNMemoryCachedObject] = [:]

    public func get<T>(key: AnyHashable) -> T? {
        guard let object = cachedObjects[key] else { return nil }
        return object.get()
    }

    public func set<T>(key: AnyHashable, value: T?, expireTime: TimeInterval? = nil) {
        if cachedObjects[key] != nil {
            cachedObjects[key]?.set(value, expireTime: expireTime)
        } else {
            cachedObjects[key] = .init(value: value, expireTime: expireTime)
        }
    }

    public func set(key: AnyHashable, expireTime: TimeInterval? = nil) {
        if cachedObjects[key] != nil {
            cachedObjects[key]?.set(expireTime: expireTime)
        } else {
            cachedObjects[key] = .init(expireTime: expireTime)
        }
    }

    public func dump() -> String {
        cachedObjects.reduce(into: "") { (result, tuple) in
            result += "{\(tuple.key): \(tuple.value)}\n"
        }
    }

    public func invalidate(key: AnyHashable) {
        cachedObjects[key]?.invalidate()
    }

    public func clearAll() {
        cachedObjects.removeAll(keepingCapacity: false)
    }
}
