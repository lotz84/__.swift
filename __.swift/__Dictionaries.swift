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
    
    class func invert<K, V>(dict: Dictionary<K, V>) -> Dictionary<V, K> {
        var result = Dictionary<V, K>()
        for (key, value) in dict {
            result[value] = key
        }
        return result
    }
    
    class func extend<K, V>(var dict0: Dictionary<K, V>, to dict1: Dictionary<K, V>) -> Dictionary<K, V> {
        for (key, value) in dict1 {
            dict0[key] = value
        }
        return dict0
    }
    
    class func pick<K, V>(from dict: Dictionary<K, V>, keys: K...) -> Dictionary<K, V> {
        var result = Dictionary<K, V>()
        for key in keys {
            if let value = dict[key] {
                result[key] = value
            }
        }
        return result
    }
    
    class func omit<K, V>(var from dict: Dictionary<K, V>, keys: K...) -> Dictionary<K, V> {
        for key in keys {
            dict.removeValueForKey(key)
        }
        return dict
    }
    
    class func defaults<K, V>(var dict: Dictionary<K, V>, defaults: Dictionary<K, V>...) -> Dictionary<K, V> {
        for option in defaults {
            for key in option.keys {
                if !dict[key] {
                    dict[key] = option[key]
                }
            }
        }
        return dict
    }
    
    class func has<K, V>(dict: Dictionary<K, V>, key: K) -> Bool {
        return dict[key].getLogicValue()
    }
    
    class func property<K, V>(key: K) -> Dictionary<K, V> -> V? {
        return { $0[key] }
    }
    
    class func matches<K, V: Equatable>(attrs: Dictionary<K, V>) -> Dictionary<K, V> -> Bool {
        return { __.hasSubDictionary($0, subDictionary: attrs) }
    }
}
