//
//  ___swiftTests.swift
//  __.swiftTests
//
//  Created by Hirose Tatsuya on 2014/06/03.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import XCTest

class ___swiftTests: XCTestCase {
    
    func testEach() {
        
        var sum = 0
        
        __.each([1,2,3],{
            item in
            sum += item
            })
        
        XCTAssert(sum == 6)
    }
    
    func testMap() {
        
        let result = __.map([1,2,3], {
            item in
            item * 2
            })
        
        XCTAssert(result == [2,4,6])
    }
    
    func testReduce(){
        var result = __.reduce([1,2,3,4], iterator: {
                x, y in
                x + y
            }, memo: 0)
        
        XCTAssert(result==10)
    }
    
    func testFind() {
        
        let result0 = __.find([1,2,3], {
                item in
                item == 2
            })
        XCTAssert(result0!==2)
        
        let result1 = __.find([1,2,3], {
            item in
            item == 4
            })
        
        var flag = false;
        if result1 {
            flag = false
        } else {
            flag = true
        }
        
        XCTAssert(flag)
    }

    func testFilter(){

        var result = __.filter([1,2,3,4], {
            x in
            x % 2 == 0
            })
        
        XCTAssert(result==[2,4])
    }
    
    func testReject(){
        
        var result = __.reject([1,2,3,4], {
            x in
            x % 2 == 0
            })
        
        XCTAssert(result==[1,3])
    }
    
    func testEvery(){
    
        var result0 = __.every([true, true, true])
        
        XCTAssert(result0)
        
        var result1 = __.every([true, true, false])
        
        XCTAssert(!result1)
    
    }
    
    func testSome(){
        
        var result0 = __.some([false, false, false])
        
        XCTAssert(!result0)
        
        var result1 = __.some([false, true, false])
        
        XCTAssert(result1)
        
    }
    
    
    func testContains(){
        
        let result0 = __.contains([1,2,3,4], value: 1)
        
        XCTAssert(result0)
        
        let result1 = __.contains([1,2,3,4], value: 5)
        
        XCTAssert(!result1)
    }
    
    func testPluck(){
        
        let data = [
            ["plan": "walking", "time": "8 a.m."],
            ["plan": "work",    "time": "10 a.m."],
            ["plan": "lunch",   "time": "12 a.m."]
        ]
        
        let result = __.pluck(data, key: "plan")
        
        XCTAssert(result == ["walking", "work", "lunch"])
    }
    
    func testMax(){
        let max = __.max([5,3,7,5,1,9,3])
        XCTAssert(max==9)
    }
    
    func testMin(){
        let min = __.min(["f","e","b","d","a","c","g"])
        XCTAssert(min == "a")
    }
    
    func testSortBy(){
        
        let result0 = __.sortBy([4,3,7,5,8,2,6,1], iterator: {x in x})
        
        XCTAssert(result0 == [1,2,3,4,5,6,7,8])
        
        func size(text: String) -> Int {
            var length = 0
            for c in text {
                length++
            }
            return length
        }
        
        let result1 = __.sortBy(["Hello", " Swift", "!!"], iterator: size)
        
        XCTAssert(result1 == ["!!", "Hello", " Swift"])
    }
}
