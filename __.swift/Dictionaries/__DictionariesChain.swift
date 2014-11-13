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

public extension __Chain {

    public func keys<K : Hashable, V>() -> __Chain<([K])>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( Array(wrapped.keys) )
        }
        return nil
    }

    public func values<K : Hashable, V>() -> __Chain<([V])>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( Array(wrapped.values) )
        }
        return nil
    }

    public func pairs<K : Hashable, V>() -> __Chain<[(K, V)]>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( Array(wrapped) )
        }
        return nil
    }

    public func invert<K : Hashable, V : Hashable>() -> __Chain<[V:K]>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.invert(wrapped) )
        }
        return nil
    }

    public func extend<K : Hashable, V>(to dictionaries: [K:V]...) -> __Chain<[K:V]>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.extend(wrapped, to: unsafeBitCast(dictionaries, [K:V].self)) )
        }
        return nil
    }

    public func pick<K : Hashable, V>(keys: K...) -> __Chain<[K:V]>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.pick(from: wrapped, keys: unsafeBitCast(keys, K.self)) )
        }
        return nil
    }

    public func omit<K : Hashable, V>(keys: K...) -> __Chain<[K:V]>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.omit(from: wrapped, keys: unsafeBitCast(keys, K.self)) )
        }
        return nil
    }

    public func defaults<K : Hashable, V>(to dictionaries: [K:V]...) -> __Chain<[K:V]>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.defaults(wrapped, defaults: unsafeBitCast(dictionaries, [K:V].self)) )
        }
        return nil
    }

    public func tap<U>(interceptor: WrappedType -> U) -> __Chain<WrappedType> {
        interceptor(self._wrapped)
        return self
    }

    public func has<K : Hashable, V>(key: K) -> __Chain<Bool>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.has(wrapped, key: key) )
        }
        return nil
    }

    // property function is not implemented

    public func matches<K, V: Equatable>() -> __Chain<[K:V] -> Bool>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.matches(wrapped) )
        }
        return nil
    }

    public func isEmpty<U>() -> __Chain<Bool>! {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( wrapped.isEmpty )
        }
        return nil
    }

    
//    public func isEmpty<K : Hashable, V>() -> __Chain<Bool>! {
//        if let wrapped = self._wrapped as? [K:V] {
//            return __.chain( wrapped.count == 0 )
//        }
//        return nil
//    }

    public func isArray<U>() -> Bool {
        if let _ = self._wrapped as? [U] {
            return true
        }
        return false
    }

    public func isDictionary<K : Hashable, V>() -> Bool {
        if let _ = self._wrapped as? [[K:V]] {
            return true
        }
        return false
    }

    public func isString() -> Bool {
        if let _ = self._wrapped as? String {
            return true
        }
        return false
    }

    public func isInt() -> Bool {
        if let _ = self._wrapped as? Int {
            return true
        }
        return false
    }

    public func isFloat() -> Bool {
        if let _ = self._wrapped as? Float {
            return true
        }
        return false
    }
    
    public func isDouble() -> Bool {
        if let _ = self._wrapped as? Double {
            return true
        }
        return false
    }
    
    public func isBoolean() -> Bool {
        if let _ = self._wrapped as? Bool {
            return true
        }
        return false
    }
    
//    func isNil() -> Bool? {
//        if self._wrapped == nil {
//            return true
//        }
//        return false
//    }
}