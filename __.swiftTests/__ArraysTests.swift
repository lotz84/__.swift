//
//  __ArraysTests.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/07.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
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
        
        let item0: Int? = 1
        let item1: Int? = nil
        let item2: Int? = 2
        
        let compacted: Int?[] = __.compact([item0, item1, item2]);
        let unwrapped = compacted.map { $0! }
        
        XCTAssert(unwrapped == [1,2])
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
    
    func testZip(){
        
        let zip = __.zip([1,2,3,4], ["a", "b", "c"])
        
        XCTAssert(zip.count == 3)
    
    }
}
