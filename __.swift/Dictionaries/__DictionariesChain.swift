//
//  __DictionariesChain.swift
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

extension __.Chain {

    func keys<K : Hashable, V>() -> __.Chain<(K[])>? {
        if let wrapped = self._wrapped as? Dictionary<K,V> {
            return __.chain( Array(wrapped.keys) )
        }
        return nil
    }

    func values<K : Hashable, V>() -> __.Chain<(V[])>? {
        if let wrapped = self._wrapped as? Dictionary<K,V> {
            return __.chain( Array(wrapped.values) )
        }
        return nil
    }

    func pairs<K : Hashable, V>() -> __.Chain<(K, V)[]>? {
        if let wrapped = self._wrapped as? Dictionary<K,V> {
            return __.chain( Array(wrapped) )
        }
        return nil
    }

    func invert<K : Hashable, V : Hashable>() -> __.Chain<Dictionary<V,K>>? {
        if let wrapped = self._wrapped as? Dictionary<K,V> {
            return __.chain( __.invert(wrapped) )
        }
        return nil
    }

    func extend<K : Hashable, V>(to dictionaries: Dictionary<K, V>...) -> __.Chain<Dictionary<K, V>>? {
        if let wrapped = self._wrapped as? Dictionary<K,V> {
            return __.chain( __.extend(wrapped, to: dictionaries) )
        }
        return nil
    }

    func pick<K : Hashable, V>(keys: K...) -> __.Chain<Dictionary<K, V>>? {
        if let wrapped = self._wrapped as? Dictionary<K,V> {
            return __.chain( __.pick(from: wrapped, keys: keys) )
        }
        return nil
    }

    func omit<K : Hashable, V>(keys: K...) -> __.Chain<Dictionary<K, V>>? {
        if let wrapped = self._wrapped as? Dictionary<K,V> {
            return __.chain( __.omit(from: wrapped, keys: keys) )
        }
        return nil
    }

    func defaults<K : Hashable, V>(to dictionaries: Dictionary<K, V>...) -> __.Chain<Dictionary<K, V>>? {
        if let wrapped = self._wrapped as? Dictionary<K,V> {
            return __.chain( __.defaults(wrapped, defaults: dictionaries) )
        }
        return nil
    }

    func tap<U>(interceptor: T -> U) -> __.Chain<T> {
        interceptor(self._wrapped)
        return self
    }

    func has<K : Hashable, V>(key: K) -> __.Chain<Bool>? {
        if let wrapped = self._wrapped as? Dictionary<K,V> {
            return __.chain( __.has(wrapped, key: key) )
        }
        return nil
    }

    // property function is not implemented

    func matches<K, V: Equatable>() -> __.Chain<Dictionary<K, V> -> Bool>? {
        if let wrapped = self._wrapped as? Dictionary<K,V> {
            return __.chain( __.matches(wrapped) )
        }
        return nil
    }

    func isEmpty<U>() -> __.Chain<Bool>? {
        if let wrapped = self._wrapped as? U[] {
            return __.chain( wrapped.isEmpty )
        }
        return nil
    }

    func isEmpty<K : Hashable, V>() -> __.Chain<Bool>? {
        if let wrapped = self._wrapped as? Dictionary<K, V> {
            return __.chain( wrapped.count == 0 )
        }
        return nil
    }

    func isArray<U>() -> Bool {
        if let wrapped = self._wrapped as? U[] {
            return true
        }
        return false
    }

    func isDictionary<K : Hashable, V>() -> Bool {
        if let wrapped = self._wrapped as? Dictionary<K, V>[] {
            return true
        }
        return false
    }

    func isString() -> Bool {
        if let wrapped = self._wrapped as? String {
            return true
        }
        return false
    }

    func isInt() -> Bool {
        if let wrapped = self._wrapped as? Int {
            return true
        }
        return false
    }

    func isFloat() -> Bool {
        if let wrapped = self._wrapped as? Float {
            return true
        }
        return false
    }
    
    func isDouble() -> Bool {
        if let wrapped = self._wrapped as? Double {
            return true
        }
        return false
    }
    
    func isBoolean() -> Bool {
        if let wrapped = self._wrapped as? Bool {
            return true
        }
        return false
    }
    
    func isNil() -> Bool? {
        return self._wrapped == nil
    }
}