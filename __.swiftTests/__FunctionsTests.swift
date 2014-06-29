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
        let fibonacci: Int -> Int = __.memoize { fibonacci, n in
            return n < 2 ? n: fibonacci(n - 1) + fibonacci(n - 2)
        }
        
        XCTAssert(fibonacci(5) == 5)
    }
    
    func testThrottle(){
    
        let throttle:Int -> Int? = __.throttle(__.identity, wait: 99999)
        
        XCTAssert(throttle(1) != nil)
        XCTAssert(throttle(1) == nil)
    }
    
    func testOnce(){
        func addTwoString(s0: String, s1: String) -> String {
            return s0 + s1
        }
        let onceAddTwoString = __.once(addTwoString)
        
        let result0 = onceAddTwoString(("swi", "ft"))
        
        XCTAssert(result0 == "swift")
        
        let result1 = onceAddTwoString(("swi", "ft"))
        
        XCTAssert(result1 == nil)
    }
    
    func testAfter(){
    
        let after = __.after(3) { "!!" }
        
        XCTAssert(after()==nil)
        
        XCTAssert(after()==nil)
        
        XCTAssert(after()=="!!")
    }
    
    func testWrap(){
        let wrapped = __.wrap({ (str: String) in str + "!!" }, withWrapper: {(f: String -> String, str: (str0: String, str1:String)) -> String in
            return str.str0 + " " + f("Hey") + " " + str.str1
        })
        
        XCTAssert(wrapped(arg: ("This", "What")) == "This Hey!! What")
    }
    
    func testCompose(){
        func f(str: String) -> (String, String) {
            return (str.uppercaseString, str.lowercaseString)
        }
        func g(str0: String, str1: String) -> String {
            return str0 + " " + str1
        }
        
        let h = __.compose(g, f)
        
        XCTAssert(h(x: "hey") == "HEY hey")
    }
}