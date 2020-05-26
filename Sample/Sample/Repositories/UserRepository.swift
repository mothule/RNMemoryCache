//
//  UserRepository.swift
//  Sample
//
//  Created by motoki kawakami on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation
import RNMemoryCache

class UserRepository {
    private var cache: RNCache<User> = RNCache<User>(key: "user", expireTime: 10 * 60)
    
    func fetchRemote() -> User? {
        if let user = cache.value {
            print("Cache hit!")
            return user
        }
        
        // Asynchronous processing is omitted.
        return userViaAwesomeAPIClient()
    }
    
    private func userViaAwesomeAPIClient() -> User {
        Thread.sleep(forTimeInterval: 3)
        let user = User(name: "Foo", age: 1)
        cache.value = user
        return user
    }
}
