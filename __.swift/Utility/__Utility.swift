//
//  __Utility.swift
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

import Foundation

var __uniqueIdCache : Dictionary<String, Int> = [:]

extension __ {

    class func identity<T>(x:T) -> T {
        return x
    }
    
    class func constant<T>(x:T) -> () -> T {
        return { x }
    }
    
    class func times<T>(n: Int, _ iterator: Int -> T ) -> T[] {
        var result : T[] = []
        for i in 0..n {
            result += iterator(i)
        }
        return result
    }
    
    class func random(n: Int) -> Int {
        return __.random(min: 0, max: n)
    }
    
    class func random(#min: Int, max: Int) -> Int {
        return min + Int(arc4random() % UInt32(max-min+1))
    }
    
    class func uniqueId(id: String) -> String {
        if let count = __uniqueIdCache[id] {
            __uniqueIdCache[id] = count + 1
            return id + String(count + 1)
        } else {
            __uniqueIdCache[id] = 0
            return id + String(0)
        }
    }
    
    class func escape(var str: String) -> String {
        return [
            ("&",  "&amp;"),
            ("<",  "&lt;"),
            (">",  "&gt;"),
            ("\"", "&quot;"),
            ("'",  "&#x27;")
        ].reduce(str) {
            $0.stringByReplacingOccurrencesOfString($1.0, withString: $1.1, options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
    }
    
    class func unescape(var str: String) -> String {
        return reduce([
            "&amp;"  : "&",
            "&lt;"   : "<",
            "&gt;"   : ">",
            "&quot;" : "\"",
            "&#x27;" : "'"
        ] , str) {
            $0.stringByReplacingOccurrencesOfString($1.0, withString: $1.1, options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
    }
}