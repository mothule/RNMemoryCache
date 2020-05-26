# RNMemoryCache
An Object cacheable on local memory in iOS


## Features

- Provides a key-value type cache common to memory areas.
- Expiration date can be set for each key.
- Even if the cache object is scoped out, the cache itself remains.

## Usage

```swift
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
```
