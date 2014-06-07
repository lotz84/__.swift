//
//  __ArraysTests.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/07.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import XCTest

class ___ArraysTests: XCTestCase {
    
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
    
}
