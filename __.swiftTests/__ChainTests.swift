//
//  __ChainTests.swift
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

class __ChainTests: XCTestCase {
    
    func testChain(){
        let r0: [Int]  = __.chain([1,2,3]).map({ $0 * 2 }).value()
        let r1: [Int]  = __.chain([1,4,2,6,4,8,2]).sortBy(__.identity).value()
        
        let data: [[String:String]] = [
            ["species": "spider", "legs": "8"],
            ["species": "ant", "legs": "6"],
            ["species": "cat", "legs": "4"]
        ]
        
        var chain: __Chain<[String]> = __.chain(data).pluck("legs")
        let r2: [Int] = chain.map({(s:String) -> Int in s.toInt()! }).filter({ $0 <= 6 }).sortBy(__.identity).value()
        
        XCTAssert(r0 == [2,4,6])
        XCTAssert(r1 == [1,2,2,4,4,6,8])
        XCTAssert(r2 == [4,6])
    }
    
}