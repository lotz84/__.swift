//
//  __Functions.swift
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

extension __ {
    
    // partially act to function which takes 2 variables
    class func partial<T, U, V>(f: (T, U) -> V, _ arg: T ) -> ( U -> V ) {
        return { f(arg, $0) }
    }
    
    // partially act to function which takes 3 variables
    class func partial<T, U, V, W>(f: (T, U, V) -> W, _ arg: T ) -> ( (U , V) -> W ) {
        return { f(arg, $0, $1) }
    }
    
    // partially act to function which takes 4 variables
    class func partial<T, U, V, W, X>(f: (T, U, V, W) -> X, _ arg: T ) -> ( (U , V, W) -> X ) {
        return { f(arg, $0, $1, $2) }
    }
    
    // partially act to function which takes 5 variables
    class func partial<T, U, V, W, X, Y>(f: (T, U, V, W, X) -> Y, _ arg: T ) -> ( (U , V, W, X) -> Y ) {
        return { f(arg, $0, $1, $2, $3) }
    }
    
    // partially act to function which takes 6 variables
    class func partial<T, U, V, W, X, Y, Z>(f: (T, U, V, W, X, Y) -> Z, _ arg: T ) -> ( (U , V, W, X, Y) -> Z ) {
        return { f(arg, $0, $1, $2, $3, $4) }
    }
    
    // partially act to function which takes 7 variables
    class func partial<T, U, V, W, X, Y, Z, A>(f: (T, U, V, W, X, Y, Z) -> A, _ arg: T ) -> ( (U , V, W, X, Y, Z) -> A ) {
        return { f(arg, $0, $1, $2, $3, $4, $5) }
    }
    
    class func memoize<T: Hashable, V>(f: T -> V) -> T -> V {
        var cache = Dictionary<T, V>()
        func memoized(arg: T) -> V {
            if let value = cache[arg] {
                return value
            } else {
                let value = f(arg)
                cache[arg] = value
                return value
            }
        }
        return memoized
    }
    
    class func once<T, U>(f: (T)-> U) -> T -> U? {
        var isExecuted = false
        func executor(arg: (T)) -> U? {
            if isExecuted {
                return nil
            } else {
                isExecuted = true
                return f(arg)
            }
        }
        return executor
    }
    
    class func after<T, U>(count: Int, function: T -> U ) -> T -> U? {
        var now = 0
        func executor(arg:T) -> U? {
            now += 1
            return now < count ? nil : function(arg)
        }
        return executor
    }
    
    class func now() -> Double {
        return NSDate().timeIntervalSince1970
    }
    
    class func wrap<T, U, V, W>(f: T -> U, withWrapper wrapper:(T -> U , V) -> W) -> V -> W {
        func executor(arg: V) -> W {
            return wrapper(f, arg)
        }
        return executor
    }
    
    class func compose<T, U, V>(g: U -> V, _ f: T -> U) -> T -> V {
        func h(arg: T) -> V {
            return g(f(arg))
        }
        return h
    }
}