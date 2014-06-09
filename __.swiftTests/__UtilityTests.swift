//
//  __UtilityTests.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/10.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import XCTest

class __UtilityTests: XCTestCase {
    
    func testIdentity() {
        
        XCTAssert(__.identity(1) == 1)
    }
    
    func testConstant() {
    
        let const = __.constant("a")

        XCTAssert(const() == "a")
    }

    func testTimes(){
        
        let result = __.times(4) { 2 * $0 }

        XCTAssert(result == [0,2,4,6])
    }
    
    func testRandom(){
    
        let result = __.random(min:10, max:30)
        
        XCTAssert(result > 9)
        XCTAssert(result < 31)
    }
}
