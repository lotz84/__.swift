//
//  __Utility.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/10.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import Foundation

extension __ {

    class func identity<T>(x:T) -> T {
        return x
    }
    
    class func constant<T>(x:T) -> () -> T {
        return { x }
    }
    
    class func times<T>(n: Int, _ iterator: Int -> T ) -> Array<T> {
        var result = Array<T>()
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
}