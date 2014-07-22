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

public extension __ {

    /**
    * Dictionaries Functions
    */
    
    public class func invert<K, V>(dict: [K:V]) -> [V:K] {
        var result : [V:K] = [:]
        for (key, value) in dict {
            result[value] = key
        }
        return result
    }
    
    public class func extend<K, V>(var dict: [K:V], to dictionaries: [K:V]...) -> [K:V] {
        for item in dictionaries {
            for (key, value) in item {
                dict[key] = value
            }
        }
        return dict
    }
    
    public class func pick<K, V>(from dict: [K:V], keys: K...) -> [K:V] {
        var result : [K:V] = [:]
        for key in keys {
            if let value = dict[key] {
                result[key] = value
            }
        }
        return result
    }
    
    public class func omit<K, V>(var from dict: [K:V], keys: K...) -> [K:V] {
        for key in keys {
            dict.removeValueForKey(key)
        }
        return dict
    }
    
    public class func defaults<K, V>(var dict: [K:V], defaults: [K:V]...) -> [K:V] {
        for option in defaults {
            for key in option.keys {
                if !dict[key] {
                    dict[key] = option[key]
                }
            }
        }
        return dict
    }
    
    public class func has<K, V>(dict: [K:V], key: K) -> Bool {
        return dict[key].getLogicValue()
    }
    
    public class func property<K, V>(key: K)(dict: [K:V]) -> V? {
        return dict[key]
    }
    
    public class func matches<K, V: Equatable>(attrs: [K:V])(dict: [K:V]) -> Bool {
        let eqList = map(attrs) { (key: K, value: V) -> Bool in
            if let v = dict[key] {
                return v == value
            } else {
                return false
            }
        }
        return Array(eqList).reduce(true) { $0 && $1 }
    }
    
}
