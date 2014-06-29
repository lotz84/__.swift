//
//  __DictionariesTests.swift
//  __.swift
//
//  Copyright (c) 2014 Tatsuya Hirose
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest

class __DictionariesTests: XCTestCase {
    
    func testInvert() {
        
        let inverted = __.invert(["a":1, "b":2])
        
        XCTAssert(inverted[1]! == "a")
    }
    
    func testExtend() {
        
        let extended = __.extend(["a":1, "b":2], to: ["c":3], ["d":4])
        
        XCTAssert(__.size(extended) == 4 )
    }
    
    func testPick() {
    
        let picked = __.pick(from: ["a":1, "b":2, "c":3, "d":4], keys: "a", "b", "c")
    
        XCTAssert(__.size(picked) == 3)
    }
    
    func testOmit() {
        
        let omitted = __.omit(from: ["a":1, "b":2, "c":3, "d":4], keys: "a", "b", "c")
        
        XCTAssert(__.size(omitted) == 1)
    }
    
    func testDefaults() {
        
        let dict = __.defaults(["a":1], defaults: ["b":2, "c":3], ["b":4, "d": 5])
        
        XCTAssert(__.size(dict) == 4)
        XCTAssert(dict["b"]! == 2)
    }
    
    func testHas() {
    
        let result = __.has(["a":1, "b":2, "c":3, "d":4], key: "b")
        
        XCTAssert(result)
    }
    
    func testProperty() {
        
        let value = __.property("a")(dict: ["a":1, "b":2, "c":3, "d":4])
        
        XCTAssert(value == 1)
    }
    
    func testMatches(){
        
        let result = __.matches(["a":1, "b":2])(dict: ["a":1, "b":2, "c":3, "d":4])
        
        XCTAssert(result)
    }
    
}
