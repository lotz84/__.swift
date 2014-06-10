//
//  __Dictionaries.swift
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
