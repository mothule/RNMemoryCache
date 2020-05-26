//
//  RNMemoryCacheSpec.swift
//  RNMemoryCacheTests
//
//  Created by mothule on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RNMemoryCache

class RNMemoryCacheSpec: QuickSpec {
    override func spec() {
        describe("RNMemoryCache") {
            var target: RNMemoryCache!
            
            beforeEach {
                target = RNMemoryCache()
            }
            
            describe("get<T>(key:)") {
                beforeEach {
                    target.set(key: "key", value: User.sample)
                }
                
                context("When have exist key") {
                    it("") {
                        let user: User? = target.get(key: "key")
                        expect(user).to(bePresent())
                    }
                }
                
                context("When have no exist key") {
                    it("") {
                        let user: User? = target.get(key: "no-exiting-key")
                        expect(user).to(beNil())
                    }
                }
            }
            
            describe("set<T>(key:value:expireTime)") {
                context("When overwrite key") {
                    beforeEach {
                        target.set(key: "key", value: User.sample, expireTime: 3)
                    }
                    it("") {
                        let newUser = User.sample
                        target.set(key: "key", value: newUser, expireTime: 3)
                        let user: User? = target.get(key: "key")
                        expect(user).to(bePresent())
                        expect(user) == newUser
                    }
                }
                context("When new key") {
                    it("") {
                        target.set(key: "key", value: User.sample, expireTime: 3)
                        let user: User? = target.get(key: "key")
                        expect(user).to(bePresent())
                    }
                }
            }
            
            describe("set(key:expireTime)") {
                context("When overwrite key") {
                    beforeEach {
                        target.set(key: "key", value: User.sample, expireTime: 3)
                    }
                    it("") {
                        target.set(key: "key", expireTime: 10)
                    }
                }
                context("When new key") {
                    it("") {
                        target.set(key: "key", expireTime: 3)
                    }
                }
            }
            
            describe("clearAll()") {
                beforeEach {
                    target.set(key: "key", value: User.sample, expireTime: 3)
                }
                it("") {
                    var user: User? = target.get(key: "key")
                    expect(user).to(bePresent())
                    target.clearAll()
                    user = target.get(key: "key")
                    expect(user).to(beNil())
                }
            }
            
            describe("invalidate(key:)") {
                beforeEach {
                    target.set(key: "key", value: User.sample, expireTime: 3)
                }
                it("") {
                    target.invalidate(key: "key")
                    let user: User? = target.get(key: "key")
                    expect(user).to(beNil())
                }
            }
            
            describe("dump()") {
                beforeEach {
                    target.set(key: "key", value: User.sample, expireTime: 3)
                }
                it("") {
                    print(target.dump())
                }
            }

        }
    }
}

