//
//  RNStandaloneCacheSpec.swift
//  RNMemoryCacheTests
//
//  Created by mothule on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RNMemoryCache

class RNStandaloneCacheSpec: QuickSpec {
    override func spec() {
        describe("RNStandaloneCache") {
            var initialValue: User?
            var interval: TimeInterval!
            var target: RNStandaloneCache<User> {
                RNStandaloneCache<User>(initial: initialValue, interval: interval)
            }
            var user: User { User(first: "foo", last: "bar") }
                        
            describe("about cached object accessor") {
                var subject: RNStandaloneCache<User>!
                
                context("When initial value is nil") {
                    beforeEach {
                        initialValue = nil
                        interval = 10
                        subject = target
                    }
                    
                    it("return nil") { expect(subject.value).to(beNil()) }
                    it("return default value") { expect(subject.valueOr(.empty)) == User.empty }
                    it("Can set new object") {
                        expect(subject.value).to(beNil())
                        subject.value = user
                        expect(subject.value).to(bePresent())
                        expect(subject.value) == user
                    }
                }
                
                context("When initial value is not nil") {
                    beforeEach {
                        initialValue = user
                        interval = 10
                        subject = target
                    }
                    
                    it("return not nil") { expect(subject.value).to(bePresent()) }
                    it("return cached value") { expect(subject.value!) == initialValue! }
                    it("return not default value") { expect(subject.valueOr(.empty)).toNot(equal(User.empty)) }
                    it("return cached value") { expect(subject.valueOr(.empty)) == initialValue! }
                    it("Can set nil") {
                        expect(subject.value).to(bePresent())
                        expect(subject.isExpired) == false
                        subject.value = nil
                        expect(subject.value).to(beNil())
                        expect(subject.isExpired) == true
                    }
                }
            }
            
            describe("about expiration") {
                var subject: RNStandaloneCache<User>!

                context("When interval is no long time") {
                    
                    beforeEach {
                        initialValue = user
                        interval = 0.5
                        subject = target
                    }

                    it("") {
                        expect(subject.isExpired) == false
                        Thread.sleep(forTimeInterval: 1.0)
                        expect(subject.isExpired) == true
                    }
                    
                    it("") {
                        expect(subject.value).to(bePresent())
                        Thread.sleep(forTimeInterval: 1.0)
                        expect(subject.value).to(beNil())
                    }
                }
                
                context("When interval is long time") {
                    beforeEach {
                        initialValue = user
                        interval = 10
                        subject = target
                    }

                    it("") {
                        expect(subject.isExpired) == false
                        Thread.sleep(forTimeInterval: 1.0)
                        expect(subject.isExpired) == false
                    }
                    
                    it("") {
                        expect(subject.value).to(bePresent())
                        Thread.sleep(forTimeInterval: 1.0)
                        expect(subject.value).to(bePresent())
                    }
                    
                    it("Can expire") {
                        expect(subject.isExpired) == false
                        subject.expire()
                        expect(subject.isExpired) == true
                    }
                }
            }
        }
    }
}
