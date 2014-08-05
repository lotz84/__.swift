//
//  __ArraysTests.swift
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

class __ArraysTests: XCTestCase {
    
    func testFirst(){
        
        let result0 = __.first([1,2,3])
        
        XCTAssert(result0 == 1)
        
        let result1 = __.first(["a","b","c"])
        
        XCTAssert(result1 == "a")
        
        let result2 = __.first([1,2,3], 2)
        
        XCTAssert(result2 == [1,2])
    }
    
    func testInitial(){
        
        let result0 = __.initial([1,2,3,4,5])
        
        XCTAssert(result0==[1,2,3,4])
        
        
        let result1 = __.initial([1,2,3,4,5], 3)
        
        XCTAssert(result1==[1,2])
    }
    
    func testLast(){
        
        let result0 = __.last([1,2,3,4,5])
        
        XCTAssert(result0==5)
        
        let result1 = __.last([1,2,3,4,5], 3)
        
        XCTAssert(result1==[3,4,5])
    }
    
    func testRest(){
        
        let rest0 = __.rest([1,2,3,4,5])
        XCTAssert(rest0 == [2,3,4,5])
        
        
        let rest1 = __.rest([1,2,3,4,5], 3)
        XCTAssert(rest1 == [4,5])
    }
    
    func testCompact(){
//        
//        let item0: Int? = 1
//        let item1: Int? = nil
//        let item2: Int? = 2
//        
//        let compacted: [Int?] = __.compact([item0, item1, item2]);
//        let unwrapped = compacted.map { $0 == nil }
//        
//        XCTAssert(unwrapped == [1,2])
    }
    
    func testFlatten(){
        
        let list = [[1,2], [3,4], [5,6,7]]
        
        let flattened = __.flatten(list)
        
        XCTAssert(flattened == [1,2,3,4,5,6,7])
    }
    
    func testWithout(){
        
        let without = __.without([1,2,3,4,5,6,7,8,9], values: 2, 4, 6, 8)
        
        XCTAssert(without == [1,3,5,7,9])
    }
    
    func testPartition(){
        
        let result = __.partition([1,2,3,4,5,6], { $0 % 2 == 0 })
        
        XCTAssert(result.0 == [2,4,6])
        XCTAssert(result.1 == [1,3,5])
    }
    
    func testUnion(){
    
        let r : [Int] = __.union([1, 2, 3], [101, 2, 1, 10], [2, 1])
        
        XCTAssert(r == [1, 2, 3, 101, 10])
    }
    
    func testIntersection(){
        
        let r : [Int] = __.intersection([1, 2, 3], [101, 2, 1, 10], [2, 1])
        
        XCTAssert(r == [1,2])
    }
    
    func testDifference(){
        
        let r : [Int] = __.difference([1, 2, 3, 4, 5], others: [5, 2, 10])
        
        XCTAssert(r == [1,3,4])
    }
    
    func testUniq(){
        
        let r0: [Int] = __.uniq([1,1,2,2,3,3,2,2,1,1])
        let r1: [Int] = __.uniq([1,1,2,2,3,3,4,4], isSorted: true)
        let r2: [Int] = __.uniq([1,1,2,2,3,3,4,4,5,5,6,6,7,7], isSorted: false, transform: { $0 % 3})
        
        XCTAssert(r0 == [1,2,3])
        XCTAssert(r1 == [1,2,3,4])
        XCTAssert(r2 == [1,2,3])
    }
    
    func testZip(){
        
        let zip = __.zip([1,2,3,4], ["a", "b", "c"])
        
        XCTAssert(zip.count == 3)
    }
    
    func testObject() {
    
        let result0 = __.object(keys: ["a", "b", "c", "d"], values: [1,2,3])
        
        XCTAssert(__.size(result0) == 3)
        
        let result1 = __.object([("a", 1),("b", 2),("c", 3)])
        
        XCTAssert(__.size(result1) == 3)
    }
    
    func testIndexOf(){
    
        let index0 = __.indexOf([1,2,3,4], value: 3)
        
        XCTAssert(index0! == 2)
        
        
        let index1 = __.indexOf([1,2,3,4], value: 5)
        
        XCTAssert(index1 == nil)
        
        
        let index2 = __.indexOf([1,2,3,4,5,6], value: 3, isSorted: true)
        
        XCTAssert(index2! == 2)
        
        
        let index3 = __.indexOf([1,2,3,4,5,6], value: 7, isSorted: true)
        
        XCTAssert(index3 == nil)
    }
    
    func testLastIndexOf(){
    
        let index0 = __.lastIndexOf([1,2,3,4,5], value: 4)
        
        XCTAssert(index0! == 3)
        
        
        let index1 = __.lastIndexOf([1,2,3,4,5], value: 6)
        
        XCTAssert(index1 == nil)
        
        let index2 = __.lastIndexOf([1,2,3,4,5], value: 4, from: 2)
        
        XCTAssert(index2 == nil)
    }
    
    func testSortedIndex(){
        
        let index = __.sortedIndex([1,2,3,4], value: 6, transform: { $0 % 4 })
        
        XCTAssert(index == 1)
    }
    
    func testRange(){
        
        let range0 = __.range(5)
        
        XCTAssert(range0==[0,1,2,3,4])
        
    }
}
