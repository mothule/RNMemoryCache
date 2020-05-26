//
//  RNCacheSpec.swift
//  RNMemoryCacheTests
//
//  Created by mothule on 2020/05/26.
//  Copyright © 2020 mothule. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RNMemoryCache

class RNCacheSpec: QuickSpec {
    override func spec() {
        describe("RNCache") {
            var target: RNCache<User>!
            beforeEach {
                target = RNCache<User>(key: "user", expireTime: 0.5)
            }
            
            describe("value computed property") {
                it("") {
                    target.value = User.sample
                    expect(target.value).to(bePresent())
                    Thread.sleep(forTimeInterval: 0.5)
                    expect(target.value).to(beNil())
                }
            }
            
            describe("invalidate()") {
                it("") {
                    target.value = User.sample
                    expect(target.value).to(bePresent())
                    target.invalidate()
                    expect(target.value).to(beNil())
                }
            }
        }
    }
}


