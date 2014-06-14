//
//  __CollectionsTests.swift
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


class __CollectionsTests: XCTestCase {

    func testEach() {
        
        var sum = 0
        
        __.each([1,2,3]) {
            sum += $0
        }
        
        XCTAssert(sum == 6)
        
        __.each(["a":0, "b":1]) {
            sum += $1
        }
        
        
        XCTAssert(sum == 7)
    }

    func testReduceRight(){
        
        var result = __.reduceRight(["a","b","c","d"], initial: "", combine: { $0 + $1 } )
        
        XCTAssert(result=="abcd")
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

    func testWhereAndFindWhere(){
        
        let data = [
            ["plan": "walking",       "time": "8 a.m."],
            ["plan": "work",          "time": "10 a.m."],
            ["plan": "lunch",         "time": "12 a.m."],
            ["plan": "meet friend",   "time": "12 a.m."]
        ]
        
        let result = __.`where`(data, ["time": "12 a.m."])
        
        XCTAssert(result.count == 2)
        
        if let result = __.findWhere(data, ["time": "12 a.m."]) {
            XCTAssert(result["plan"]=="lunch")
        } else {
            XCTAssert(false)
        }
        
        if __.findWhere(data, ["time": "3 a.m."]) {
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
        
        let max0 = __.max([5,3,7,5,1,9,3])
        
        XCTAssert(max0==9)
        
        let max1 = __.max(5,3,7,5,1,9,3)
        
        XCTAssert(max1==9)
    }

    func testMin(){
        
        let min0 = __.min(["f","e","b","d","a","c","g"])
        
        XCTAssert( min0 == "a" )
        
        let min1 = __.min("f","e","b","d","a","c","g")
        
        XCTAssert( min1 == "a" )
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
        
        let result1 = __.sortBy(["Hello", " Swift", "!!"], size)
        
        XCTAssert(result1 == ["!!", "Hello", " Swift"])
    }

    func testGroupBy(){
        
        let result = __.groupBy([1.3, 2.1, 2.4], floor)
        
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
        XCTAssert(contains([1,2,3,4], result0))
        
        let result1 = __.sample([1,2,3,4], 3)
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