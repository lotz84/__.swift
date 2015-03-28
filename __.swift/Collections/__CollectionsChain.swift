//
//  __CollectionsChain.swift
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
    
    public func each<T>(iterator: T -> Any) -> () {
        if let wrapped = self._wrapped as? [T] {
            __.each(wrapped, iterator)
        }
    }
    
    public func each<K : Hashable, V>(iterator: (K, V) -> Any) -> () {
        if let wrapped = self._wrapped as? [K:V] {
            __.each(wrapped, iterator)
        }
    }
    
    // alias for each
    public func forEach<T>(iterator: T -> Any) -> () {
        self.each(iterator)
    }
    
    // alias for each
    public func forEach<K : Hashable, V>(iterator: (K, V) -> Any) -> () {
        self.each(iterator)
    }
    
    public func map<T, U>(transform: T -> U) -> __Chain<[U]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain(wrapped.map(transform))
        }
        return nil
    }
    
    
    public func map<K : Hashable, V, T>(transform: (K, V) -> T) -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [K:V] {
            var result : [T] = []
            var gen = wrapped.generate()
            while let elem = gen.next() {
                result.append(transform(elem))
            }
            return __.chain( result )
        }
        return nil
    }
    
    public func collect<T, U>(transform: T -> U) -> __Chain<[U]>! {
        return self.map(transform)
    }
    
    public func collect<K : Hashable, V, T>(transform: (K, V) -> T) -> __Chain<[T]>! {
        return self.map(transform)
    }
    
    public func reduce<T, U>(initial: U, combine:(U, T) -> U) -> __Chain<U>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain(wrapped.reduce(initial, combine: combine))
        }
        return nil
    }
    
    public func reduce<K : Hashable, V, T>(initial: T, combine:(T, (K, V)) -> T) -> __Chain<T>! {
        if let wrapped = self._wrapped as? [K:V] {
            var accum = initial
            var gen = wrapped.generate()
            while let elem = gen.next() {
                accum = combine(accum, elem)
            }
            return __.chain( accum )
        }
        return nil
    }
    
    // alias for reduce
    public func inject<T, U>(initial: U, combine:(U, T) -> U ) -> __Chain<U>! {
        return self.reduce(initial, combine: combine)
    }
    
    // alias for reduce
    public func inject<K : Hashable, V, T>(initial: T, combine:(T, (K, V)) -> T) -> __Chain<T>! {
        return self.reduce(initial, combine: combine)
    }
    
    // alias for reduce
    public func foldl<T, U>(initial: U, combine:(U, T) -> U ) -> __Chain<U>! {
        return self.reduce(initial, combine: combine)
    }
    
    // alias for reduce
    public func foldl<K : Hashable, V, T>(initial: T, combine:(T, (K, V)) -> T) -> __Chain<T>! {
        return self.reduce(initial, combine: combine)
    }
    
    public func reduceRight<T, U>(initial: U, combine:(T, U) -> U) -> __Chain<U>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.reduceRight(wrapped, initial: initial, combine: combine) )
        }
        return nil
    }
    
    public func reduceRight<K : Hashable, V, T>(initial: T, combine:((K, V), T) -> T) -> __Chain<T>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.reduceRight(wrapped, initial: initial, combine: combine) )
        }
        return nil
    }
    
    // alias for reduceRight
    public func foldr<T, U>(initial: U, combine:(T, U) -> U) -> __Chain<U>! {
        return self.reduceRight(initial, combine: combine)
    }
    
    // alias for reduceRight
    public func foldr<K : Hashable, V, T>(initial: T, combine:((K, V), T) -> T) -> __Chain<T>! {
        return self.reduceRight(initial, combine: combine)
    }
    
    public func find<T>(predicate: T -> Bool) -> __Chain<T?>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.find(wrapped, predicate: predicate) )
        }
        return nil
    }
    
    public func find<K : Hashable, V>(predicate: (K,V) -> Bool) -> __Chain<(K, V)?>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.find(wrapped, predicate: predicate) )
        }
        return nil
    }
    
    // alias for find
    public func detect<T>(predicate: T -> Bool) -> __Chain<T?>! {
        return self.find(predicate)
    }
    
    // alias for find
    public func detect<K : Hashable, V>(predicate: (K,V) -> Bool) -> __Chain<(K, V)?>! {
        return self.find(predicate)
    }
    
    public func filter<T>(predicate: T -> Bool) -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( wrapped.filter(predicate) )
        }
        return nil
    }
    
    public func filter<K : Hashable, V>(predicate: (K,V) -> Bool) -> __Chain<[(K, V)]>! {
        if let wrapped = self._wrapped as? [K:V] {
            var result : [(K, V)] = []
            for (key, value) in wrapped {
                if predicate(key, value) {
                    result.append(key, value)
                }
            }
            return __.chain( result )
        }
        return nil
    }
    
    // alias for filter
    public func select<T>(predicate: T -> Bool) -> __Chain<[T]>! {
        return self.filter(predicate)
    }
    
    // alias for filter
    public func select<K : Hashable, V>(predicate: (K,V) -> Bool) -> __Chain<[(K, V)]>! {
        return self.filter(predicate)
    }
    
    public func `where`<K,V: Equatable>(array: [[K:V]], _ properties: [K:V]) -> __Chain<[[K:V]]>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.`where`(array, properties) )
        }
        return nil
    }
    
    public func findWhere<K,V: Equatable>(array: [[K:V]], _ properties: [K:V]) -> __Chain<[K:V]?>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.findWhere(array, properties) )
        }
        return nil
    }
    
    public func reject<T>(predicate: T -> Bool) -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( wrapped.filter({ !predicate($0) }) )
        }
        return nil
    }
    
    public func reject<K : Hashable, V>(predicate: (K,V) -> Bool) -> __Chain<[(K, V)]>! {
        if let wrapped = self._wrapped as? [K:V] {
            return self.filter({ !predicate($0) })
        }
        return nil
    }
    
    public func every<L: BooleanType>() -> __Chain<Bool>! {
        if let wrapped = self._wrapped as? [L] {
            return __.chain( __.every(wrapped) )
        }
        return nil
    }
    
    public func every<T>(predicate: T -> Bool ) -> __Chain<Bool>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.every(wrapped, predicate: predicate) )
        }
        return nil
    }
    
    // alias for every
    public func all<L: BooleanType>() -> __Chain<Bool>! {
        return self.every({ (x:BooleanType) -> Bool in x.boolValue })
    }
    
    // alias for every
    public func all<T>(predicate: T -> Bool ) -> __Chain<Bool>! {
        return self.every(predicate)
    }
    
    public func some<L: BooleanType>() -> __Chain<Bool>! {
        if let wrapped = self._wrapped as? [L] {
            return __.chain( __.some(wrapped) )
        }
        return nil
    }
    
    public func some<T>(predicate: T -> Bool ) -> __Chain<Bool>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.some(wrapped, predicate: predicate) )
        }
        return nil
    }
    
    // alias for some
    public func any<L: BooleanType>() -> __Chain<Bool>! {
        return self.some({ (x:BooleanType) -> Bool in x.boolValue })
    }
    
    // alias for some
    public func any<T>(predicate: T -> Bool ) -> __Chain<Bool>! {
        return self.some(predicate)
    }
    
    public func contains<E : Equatable>(x: E) -> __Chain<Bool>! {
        if let wrapped = self._wrapped as? [E] {
            var gen = wrapped.generate()
            while let elem = gen.next() {
                if elem == x {
                    return __.chain(true)
                }
            }
            return __.chain(false)
        }
        return nil
    }
    
    public func contains<K : Hashable, V : Equatable>(x: (K, V)) -> __Chain<Bool>! {
        if let wrapped = self._wrapped as? [K:V] {
            for (key, value) in wrapped {
                if key==x.0 && value==x.1 {
                    return __.chain(true)
                }
            }
            return __.chain(false)
        }
        return nil
    }
    
    // alias for contains
    public func include<E : Equatable>(x: E) -> __Chain<Bool>! {
        return self.contains(x)
    }
    
    // alias for contains
    public func include<K : Hashable, V : Equatable>(x: (K, V)) -> __Chain<Bool>! {
        return self.contains(x)
    }
    
    public func pluck<K : Hashable, V>(key : K) -> __Chain<[V]>! {
        if let wrapped = self._wrapped as? [[K:V]] {
            return __.chain( __.pluck(wrapped, key: key) )
        }
        return nil
    }
    
    public func max<C : Comparable>() -> __Chain<C>! {
        if let wrapped = self._wrapped as? [C] {
            return __.chain( maxElement(wrapped) )
        }
        return nil
    }
    
    public func min<C : Comparable>() -> __Chain<C>! {
        if let wrapped = self._wrapped as? [C] {
            return __.chain( minElement(wrapped) )
        }
        return nil
    }
    
    public func sortBy<T, U : Comparable>(transform: T -> U) -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.sortBy(wrapped, transform: transform) )
        }
        return nil
    }
    
    public func groupBy<K, V>(transform: V -> K) -> __Chain<[K:[V]]>! {
        if let wrapped = self._wrapped as? [V] {
            return __.chain( __.groupBy(wrapped, transform: transform) )
        }
        return nil
    }
    
    public func indexBy<K, V>(key: K) -> __Chain<[V:[K:V]]>! {
        if let wrapped = self._wrapped as? [[K:V]] {
            return __.chain( __.indexBy(wrapped, key: key) )
        }
        return nil
    }
    
    public func countBy<T, U>(transform: T -> U) -> __Chain<[U:Int]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.countBy(wrapped, transform:transform) )
        }
        return nil
    }
    
    public func shuffle<T>() -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.shuffle(wrapped) )
        }
        return nil
    }
    
    public func sample<T>() -> __Chain<T>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.sample(wrapped) )
        }
        return nil
    }
    
    public func sample<T>(n:Int) -> __Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.sample(wrapped, n) )
        }
        return nil
    }
    
    public func size<T>() -> __Chain<Int>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.size(wrapped) )
        }
        return nil
    }
    
//    public func size<K : Hashable,V>() -> __Chain<Int>! {
//        if let wrapped = self._wrapped as? [K:V] {
//            return __.chain( __.size(wrapped) )
//        }
//        return nil
//    }
}