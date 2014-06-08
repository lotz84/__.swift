//
//  __Dictionaries.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/08.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import Foundation

extension __ {

    /**
    * Dictionaries Functions
    */
    
    class func keys<K, V>(dict: Dictionary<K,V>) -> K[]{
        return Array(dict.keys)
    }
    
    class func values<K, V>(dict: Dictionary<K,V>) -> V[]{
        return Array(dict.values)
    }
    
    class func pairs<K, V>(dict: Dictionary<K, V>) -> (K, V)[] {
        return __.zip(__.keys(dict), __.values(dict))
    }
    
}