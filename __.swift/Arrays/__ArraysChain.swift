//
//  __Chain.swift
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
    
    public func first<T>() -> __Chain<T?>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( wrapped.first )
        }
        return nil
    }
    
    // alias for first
    public func head<T>() -> __Chain<T?>! {
        return self.first()
    }
    
    // alias for first
    public func take<T>() -> __Chain<T?>! {
        return self.first()
    }
    
    public func first<T>(n: Int) -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.first(wrapped, n) )
        }
        return nil
    }
    
    // alias for first
    public func head<T>(n: Int) -> __Chain<[T]>! {
        return self.first(n)
    }
    
    // alias for first
    public func take<T>(n: Int) -> __Chain<[T]>! {
        return self.first(n)
    }
    
    public func initial<T>(n: Int = 1) -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.initial(wrapped, n) )
        }
        return nil
    }

    public func last<T>() -> __Chain<T?>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( wrapped.last )
        }
        return nil
    }
    
    public func last<T>(n: Int) -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.last(wrapped, n) )
        }
        return nil
    }
    
    public func rest<T>(n: Int = 1) -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.rest(wrapped, n) )
        }
        return nil
    }
    
    // alias for rest
    public func tail<T>(n: Int = 1) -> __Chain<[T]>! {
        return self.rest(n: n)
    }
    
    // alias for rest
    public func drop<T>(n: Int = 1) -> __Chain<[T]>! {
        return self.rest(n: n)
    }
    
    public func compact<L : BooleanType>() -> __Chain<[L]>! {
        if let wrapped = self._wrapped as? [L] {
            return __.chain( __.compact(wrapped) )
        }
        return nil
    }
    
    public func flatten<T>() -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [[T]] {
            return __.chain( __.flatten(wrapped) )
        }
        return nil
    }

    public func without<E: Equatable>( values: E...) -> __Chain<[E]>! {
        if let wrapped = self._wrapped as? [E] {
            return __.chain( __.without(wrapped, values: unsafeBitCast(values, E.self)) )
        }
        return nil
    }
    
    public func partition<T>( predicate: T -> Bool ) -> __Chain<([T], [T])>! {
        if let wrapped = self._wrapped as? [T] {
            //return __.chain( unsafeBitCast(__.partition(wrapped, predicate: predicate), (([T].self, [T].self)).self ))
        }
        return nil
    }
    
    // union and intersection functions are not implemented
    
    public func difference<E: Equatable>(array: [E], others: [E]...) -> __Chain<[E]>! {
        if let wrapped = self._wrapped as? [E] {
            return __.chain( __.difference(wrapped, others: unsafeBitCast(others, [E].self)) )
        }
        return nil
    }
    
    public func uniq<E : Equatable>(isSorted: Bool = false) -> __Chain<[E]>! {
        if let wrapped = self._wrapped as? [E] {
            return __.chain( __.uniq( wrapped, isSorted: isSorted) )
        }
        return nil
    }
    
    public func uniq<T, E : Equatable>(isSorted: Bool, transform: T -> E) -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.uniq( wrapped, isSorted: isSorted, transform: transform) )
        }
        return nil
    }
    
    // zip and object functions are not implemented
    
    public func indexOf<E: Equatable>(value:E) -> __Chain<Int?>! {
        if let wrapped = self._wrapped as? [E] {
            return __.chain( __.indexOf(wrapped, value: value) )
        }
        return nil
    }
    
    public func indexOf<C: Comparable>(value:C, isSorted: Bool) -> __Chain<Int?>! {
        if let wrapped = self._wrapped as? [C] {
            return __.chain( __.indexOf(wrapped, value: value, isSorted: isSorted) )
        }
        return nil
    }
    
    public func lastIndexOf<E : Equatable>(value: E) -> __Chain<Int?>! {
        if let wrapped = self._wrapped as? [E] {
            return __.chain( __.lastIndexOf(wrapped, value: value) )
        }
        return nil
    }
    
    public func lastIndexOf<E : Equatable>(value: E, from: Int) -> __Chain<Int?>! {
        if let wrapped = self._wrapped as? [E] {
            return __.chain( __.lastIndexOf(wrapped, value: value, from: from) )
        }
        return nil
    }
    
    public func sortedIndex<T, C : Comparable>(array : [T], value : T, transform: T -> C ) -> __Chain<Int?>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.sortedIndex(wrapped, value: value, transform: transform) )
        }
        return nil
    }
    
    // range function is not implemented

}
