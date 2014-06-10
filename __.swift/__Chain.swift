//
//  __Chain.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/10.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import Foundation

extension __ {

    /*
     * This is only chain concept here.
     * Actually, unknown error is occured before compiling.
     */

    class func chain(wrapped: AnyObject) -> __Chain {
        return __Chain(wrapped)
    }
    
    class __Chain {
        
        var _wrapped: AnyObject
        
        init(_ wrapped: AnyObject) {
            self._wrapped = wrapped
        }
        
        func value() -> AnyObject   {
            return self._wrapped
        }
        
        func each<T>(iterator: T -> Any) -> () {
            if let wrapped = self._wrapped as? T[] {
                __.each(wrapped, iterator)
            }
        }
    }
}