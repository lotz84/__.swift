//
//  __FunctionsTests.swift
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

class __FunctionsTests: XCTestCase {

    func testPartial(){
        let add = { (x: Int, y :Int) in (x+y, x, y) }
        let add5 = __.partial(add, 5)
        XCTAssert(add5(10).0==15)
        
        let triadd = { (x: Int, y: Int, z: Int) in x+y+z }
        let add6 = __.partial(triadd, 6)
        let add6and7 = __.partial(add6, 7)
        XCTAssert(add6and7(10)==23)
    }
    
    func testMemoize(){
        var fibonacci: ((Int) -> Int)?; fibonacci = __.memoize({ (n: Int) -> Int in
            return n < 2 ? n: fibonacci!(n - 1) + fibonacci!(n - 2);
        })
        
        XCTAssert(fibonacci!(5) == 5)
    }
    
}