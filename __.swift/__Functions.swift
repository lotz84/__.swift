//
//  __Functions.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/07.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
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
    
    class func now() -> Double {
        return NSDate().timeIntervalSince1970
    }
}