//
//  RNCache.swift
//  RNMemoryCache
//
//  Created by mothule on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation

/**
 ## キャッシュオブジェクト

 - warning:
    - 複数箇所で同一キーのキャッシュ宣言は避けてください.
    - 宣言元で期限時間が変えられるため、想定外の難解な不具合を生む原因となります。
 */
public struct RNCache<T> {
    private let key: String
    private let expireTime: TimeInterval?

    public init(key: String, expireTime: TimeInterval? = nil) {
        self.key = key
        self.expireTime = expireTime
        RNMemoryCache.shared.set(key: key, expireTime: expireTime)
    }

    public var value: T? {
        get {
            return RNMemoryCache.shared.get(key: key)
        }
        set {
            RNMemoryCache.shared.set(key: key, value: newValue, expireTime: expireTime)
        }
    }

    public func invalidate() {
        RNMemoryCache.shared.invalidate(key: key)
    }
}
