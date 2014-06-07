//
//  __FunctionsTests.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/07.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import XCTest

class ___FunctionsTests: XCTestCase {

    func testPartial(){
        let add = { (x: Int, y :Int) in (x+y, x, y) }
        let add5 = __.partial(add, 5)
        XCTAssert(add5(10).0==15)
        
        let triadd = { (x: Int, y: Int, z: Int) in x+y+z }
        let add6 = __.partial(triadd, 6)
        let add6and7 = __.partial(add6, 7)
        XCTAssert(add6and7(10)==23)
    }
    
}