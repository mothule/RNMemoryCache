//
//  RNMemoryCachedObjectSpec.swift
//  RNMemoryCacheTests
//
//  Created by mothule on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RNMemoryCache

class RNMemoryCachedObjectSpec: QuickSpec {
    override func spec() {
        describe("RNMemoryCachedObject") {
            var user: User { .sample }
            
            var value: User?
            var expireTime: TimeInterval?
            var object: RNMemoryCachedObject!
            var target: RNMemoryCachedObject {
                object = object ?? RNMemoryCachedObject(value: value, expireTime: expireTime)
                return object
            }
            
            beforeEach {
                value = user
                expireTime = 10
                object = nil
            }
            
            describe("get<T>()") {
                var subject: User? { target.get() }
                context("When value is nil") {
                    beforeEach {
                        value = nil
                    }
                    it("") { expect(subject).to(beNil()) }
                }
                context("When expireTime is nil") {
                    beforeEach {
                        expireTime = nil
                    }
                    it("No expiration time") {
                        expect(subject).to(bePresent())
                    }
                }
            }
            
            describe("set(:expireTime:)") {
                context("When new value is nil") {
                    it("") {
                        target.set(nil, expireTime: expireTime)
                        let user: User? = target.get()
                        expect(user).to(beNil())
                    }
                }
                context("When new expireTime is nil") {
                    it("expiration time is infinity") {
                        target.set(value, expireTime: nil)
                        let user: User? = target.get()
                        expect(user).to(bePresent())
                    }
                }
            }
            
            describe("set(expireTime:)") {
                context("When new expireTime is nil") {
                    beforeEach {
                        target.set(expireTime: nil)
                    }
                    it("expiration is infinity") {
                        let user: User? = target.get()
                        expect(user).to(bePresent())
                    }
                }
                
                context("When new expireTime is zero") {
                    beforeEach {
                        target.set(expireTime: 0)
                    }
                    it("expired") {
                        let user: User? = target.get()
                        expect(user).to(beNil())
                    }
                }
            }
            
            describe("init(value:expireTime:)") {
                var subject: RNMemoryCachedObject {
                    RNMemoryCachedObject(value: value, expireTime: expireTime)
                }

                it("") {
                    expect(target.get()) == value
                }
                context("When value is nil") {
                    beforeEach { value = nil }
                    it("") { let user: User? = target.get(); expect(user).to(beNil()) }
                }
                context("When expireTime is nil") {
                    beforeEach { expireTime = nil }
                    it("No expiration time") { expect(subject).to(bePresent()) }
                }
                context("When expireTime is not nil BUT expired") {
                    beforeEach { expireTime = 0 }
                    it("") { let user: User? = target.get(); expect(user).to(beNil()) }
                }
            }
            
            describe("invalidate()") {
                context("When expireTime is not nil") {
                    it("expire") {
                        var user: User? = target.get()
                        expect(user).to(bePresent())
                        target.invalidate()
                        user = target.get()
                        expect(user).to(beNil())
                    }
                }
                
                context("When expireTime is infinity") {
                    beforeEach { expireTime = nil }
                    it("clear value") {
                        var user: User? = target.get()
                        expect(user).to(bePresent())
                        target.invalidate()
                        user = target.get()
                        expect(user).to(beNil())
                    }
                }
            }
            
            describe("debugDescription computed property") {
                it("Don't crash") {
                    print(target.debugDescription)
                }
            }
        }
    }
}

