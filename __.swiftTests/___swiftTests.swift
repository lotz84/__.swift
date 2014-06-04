//
//  ___swiftTests.swift
//  __.swiftTests
//
//  Created by Hirose Tatsuya on 2014/06/03.
//  Copyright (c) 2014年 tatsuya hirose. All rights reserved.
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
        
        println(result)
        
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
}
