//
//  __DictionariesTests.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/08.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import XCTest

class __DictionariesTests: XCTestCase {

    func testKeys(){
        
        let keys = __.keys(["a":"A", "b":"B", "c":"C"])
        
        let has_a = __.contains(keys, value: "a")
        let has_b = __.contains(keys, value: "b")
        let has_c = __.contains(keys, value: "c")
        
        XCTAssert(has_a && has_b && has_c)
    }
    
    func testValues(){
        
        let values = __.values(["a":"A", "b":"B", "c":"C"])
        
        let has_A = __.contains(values, value: "A")
        let has_B = __.contains(values, value: "B")
        let has_C = __.contains(values, value: "C")
        
        XCTAssert(has_A && has_B && has_C)
    }
    
    func testPairs(){
        
        let pairs = __.pairs(["a":"A", "b":"B", "c":"C"])
        
        XCTAssert(pairs.count==3)
    }
    
    func testInvert() {
        
        let inverted = __.invert(["a":1, "b":2])
        
        XCTAssert(inverted[1]! == "a")
    }
    
    func testExtend() {
        
        let extended = __.extend(["a":1, "b":2], to: ["c":3, "d":4])
        
        XCTAssert(__.keys(extended).count == 4 )
    }
    
    func testPick() {
    
        let picked = __.pick(from: ["a":1, "b":2, "c":3, "d":4], keys: "a", "b", "c")
    
        XCTAssert(__.keys(picked).count == 3)
    }
    
    func testOmit() {
        
        let omitted = __.omit(from: ["a":1, "b":2, "c":3, "d":4], keys: "a", "b", "c")
        
        XCTAssert(__.keys(omitted).count == 1)
    }
    
    func testDefaults() {
        
        let dict = __.defaults(["a":1], defaults: ["b":2, "c":3], ["b":4, "d": 5])
        
        XCTAssert(__.keys(dict).count==4)
        XCTAssert(dict["b"]! == 2)
    }
    
    func testHas() {
    
        let result = __.has(["a":1, "b":2, "c":3, "d":4], key: "b")
        
        XCTAssert(result)
    }
    
    func testProperty() {
        
        let value = __.property("a")(["a":1, "b":2, "c":3, "d":4])
        
        XCTAssert(value == 1)
    }
    
    func testMatches(){
        
        let result = __.matches(["a":1, "b":2])(["a":1, "b":2, "c":3, "d":4])
        
        XCTAssert(result)
    }
    
}
