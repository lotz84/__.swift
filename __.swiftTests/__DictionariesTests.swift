//
//  __DictionariesTests.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/08.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import XCTest

class ___DictionariesTests: XCTestCase {

    class func testKeys(){
        
        let keys = __.keys(["a":"A", "b":"B", "c":"C"])
        
        XCTAssert(keys==["a", "b", "c"])
    }
    
    class func testValues(){
        
        let values = __.values(["a":"A", "b":"B", "c":"C"])
        
        XCTAssert(values==["A", "B", "C"])
    }
    
    class func testPairs(){
        
        let pairs = __.pairs(["a":"A", "b":"B", "c":"C"])
        
        XCTAssert(pairs.count==3)
    }
    
}
