//
//  __CollectionsTests.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/07.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import XCTest


class ___CollectionsTests: XCTestCase {

    func testEach() {
        
        var sum = 0
        
        __.each([1,2,3]) {
            sum += $0
        }
        
        XCTAssert(sum == 6)
    }

    func testMap() {
        
        let result = __.map([1,2,3]) {
            item in
            item * 2
        }
        
        XCTAssert(result == [2,4,6])
    }

    func testReduce(){
        
        // Actually I want to write this as ` __.reduce([1,2,3,4], memo: 0, iterator: + ) `
        // But some error occur and I can't understand.
        var result = __.reduce([1,2,3,4], memo: 0 ) { $0 + $1 }
        
        XCTAssert(result==10)
    }

    func testFind() {
        
        let result0 = __.find([1,2,3]) { $0 == 2 }
        
        XCTAssert(result0!==2)
        
        let result1 = __.find([1,2,3]) { $0 == 4 }
        
        var flag = false;
        if result1 {
            flag = false
        } else {
            flag = true
        }
        
        XCTAssert(flag)
    }

    func testFilter(){
        
        var result = __.filter([1,2,3,4]) { $0 % 2 == 0 }
        
        XCTAssert(result==[2,4])
    }
    
    func testWhereAndFindWhere(){
        
        let data = [
            ["plan": "walking",       "time": "8 a.m."],
            ["plan": "work",          "time": "10 a.m."],
            ["plan": "lunch",         "time": "12 a.m."],
            ["plan": "meet friend",   "time": "12 a.m."]
        ]
        
        let result = __.`where`(data, properties: ["time": "12 a.m."])
        
        XCTAssert(result.count == 2)
        
        if let result = __.findWhere(data, properties: ["time": "12 a.m."]) {
            XCTAssert(result["plan"]=="lunch")
        } else {
            XCTAssert(false)
        }
        
        if __.findWhere(data, properties: ["time": "3 a.m."]) {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }

    func testReject(){
        
        var result = __.reject([1,2,3,4]) { $0 % 2 == 0 }
        
        XCTAssert(result==[1,3])
    }

    func testEvery(){
        
        var result0 = __.every([true, true, true])
        
        XCTAssert(result0)
        
        var result1 = __.every([true, true, false])
        
        XCTAssert(!result1)
        
        let item0: Int? = 1
        let item1: Int? = 2
        let item2: Int? = nil
        
        var result2 = __.every([item0, item1, item2])
        
        XCTAssert(!result2)
        
    }

    func testSome(){
        
        var result0 = __.some([false, false, false])
        
        XCTAssert(!result0)
        
        var result1 = __.some([false, true, false])
        
        XCTAssert(result1)
        
        let item0: Int? = 1
        let item1: Int? = 2
        let item2: Int? = nil
        
        var result2 = __.some([item0, item1, item2])
        
        XCTAssert(result2)
        
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
        
        XCTAssert( min == "a" )
    }

    func testSortBy(){
        
        let result0 = __.sortBy([4,3,7,5,8,2,6,1]) { $0 }
        
        XCTAssert(result0 == [1,2,3,4,5,6,7,8])
        
        func size(text: String) -> Int {
            var length = 0
            for _ in text {
                length++
            }
            return length
        }
        
        let result1 = __.sortBy(["Hello", " Swift", "!!"], iterator: size)
        
        XCTAssert(result1 == ["!!", "Hello", " Swift"])
    }

    func testGroupBy(){
        
        let result = __.groupBy([1.3, 2.1, 2.4], iterator: floor)
        
        let list0 = result[1.0]!
        let list1 = result[2.0]!
        
        XCTAssert( (list0 == [1.3]) && (list1 == [2.1, 2.4]) )
    }

    func testIndexBy(){
        
        let data = [
            ["plan": "walking",       "time": "8 a.m."],
            ["plan": "work",          "time": "10 a.m."],
            ["plan": "lunch",         "time": "12 a.m."],
            ["plan": "meet friend",   "time": "12 a.m."]
        ]
        
        let result = __.indexBy(data, key: "time")
        
        XCTAssert( result["8 a.m."]!["plan"]! == "walking" )
    }

    func testCountBy(){
        
        let result = __.countBy([1, 2, 3, 4, 5]) { $0 % 2 == 0 ? "even": "odd" }
        
        XCTAssert(result["odd"]! == 3)
    }

    func testShuffle(){
        
        let result = __.shuffle(["a", "b", "c", "d", "e", "f", "g", "h"])
        
        XCTAssert(result.count == 8)
    }

    func testSample(){
        
        let result0 = __.sample([1,2,3,4])
        XCTAssert(__.contains([1,2,3,4], value: result0))
        
        let result1 = __.sample([1,2,3,4], n: 3)
        XCTAssert(result1.count == 3)
    }

    func testSize(){
        
        let result0 = __.size([1,2,3,4,5])
        XCTAssert(result0 == 5)
        
        let dict = [
            "a":1,
            "b":2,
            "c":3,
            "d":4,
            "e":5,
            "f":6
        ]
        let result1 = __.size(dict)
        XCTAssert(result1 == 6)
    }

}