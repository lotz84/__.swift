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

extension __.Chain {
    
    func first<U>() -> __.Chain<U>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.first(wrapped) )
        }
        return nil
    }
    
    // alias for first
    func head<U>() -> __.Chain<U>? {
        return self.first()
    }
    
    // alias for first
    func take<U>() -> __.Chain<U>? {
        return self.first()
    }
    
    func first<U>(n: Int) -> __.Chain<[U]>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.first(wrapped, n) )
        }
        return nil
    }
    
    // alias for first
    func head<U>(n: Int) -> __.Chain<[U]>? {
        return self.first(n)
    }
    
    // alias for first
    func take<U>(n: Int) -> __.Chain<[U]>? {
        return self.first(n)
    }
    
    func initial<U>(n: Int = 1) -> __.Chain<[U]>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.initial(wrapped, n) )
        }
        return nil
    }

    func last<U>() -> __.Chain<U>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.last(wrapped) )
        }
        return nil
    }
    
    func last<U>(n: Int) -> __.Chain<[U]>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.last(wrapped, n) )
        }
        return nil
    }
    
    func rest<U>(n: Int = 1) -> __.Chain<[U]>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.rest(wrapped, n) )
        }
        return nil
    }
    
    // alias for rest
    func tail<U>(n: Int = 1) -> __.Chain<[U]>? {
        return self.rest(n: n)
    }
    
    // alias for rest
    func drop<U>(n: Int = 1) -> __.Chain<[U]>? {
        return self.rest(n: n)
    }
    
    func compact<U : LogicValue>() -> __.Chain<[U]>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.compact(wrapped) )
        }
        return nil
    }
    
    func flatten<U>() -> __.Chain<[U]>? {
        if let wrapped = self._wrapped as? [[U]] {
            return __.chain( __.flatten(wrapped) )
        }
        return nil
    }

    func without<U: Equatable>( values: U...) -> __.Chain<[U]>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.without(wrapped, values: reinterpretCast(values)) )
        }
        return nil
    }
    
    func partition<U>( predicate: U -> Bool ) -> __.Chain<(([U], [U]))>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.partition(wrapped, predicate: predicate) )
        }
        return nil
    }
    
    // union and intersection functions are not implemented
    
    func difference<U: Equatable>(array: [U], others: [U]...) -> __.Chain<[U]>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.difference(wrapped, others: reinterpretCast(others)) )
        }
        return nil
    }
    
    func uniq<U : Equatable>(isSorted: Bool = false) -> __.Chain<[U]>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.uniq( wrapped, isSorted: isSorted) )
        }
        return nil
    }
    
    func uniq<U, V : Equatable>(isSorted: Bool, transform: U -> V) -> __.Chain<[U]>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.uniq( wrapped, isSorted: isSorted, transform: transform) )
        }
        return nil
    }
    
    // zip and object functions are not implemented
    
    func indexOf<U: Equatable>(value:U) -> __.Chain<Int?>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.indexOf(wrapped, value: value) )
        }
        return nil
    }
    
    func indexOf<U: Comparable>(value:U, isSorted: Bool) -> __.Chain<Int?>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.indexOf(wrapped, value: value, isSorted: isSorted) )
        }
        return nil
    }
    
    func lastIndexOf<U : Equatable>(value: U) -> __.Chain<Int?>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.lastIndexOf(wrapped, value: value) )
        }
        return nil
    }
    
    func lastIndexOf<U : Equatable>(value: U, from: Int) -> __.Chain<Int?>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.lastIndexOf(wrapped, value: value, from: from) )
        }
        return nil
    }
    
    func sortedIndex<U, V : Comparable>(array : [U], value : U, transform: U -> V ) -> __.Chain<Int?>? {
        if let wrapped = self._wrapped as? [U] {
            return __.chain( __.sortedIndex(wrapped, value: value, transform: transform) )
        }
        return nil
    }
    
    // range function is not implemented

}
