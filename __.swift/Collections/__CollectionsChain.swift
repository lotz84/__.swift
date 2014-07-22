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

extension __.Chain {
    
    func each<T>(iterator: T -> Any) -> () {
        if let wrapped = self._wrapped as? [T] {
            __.each(wrapped, iterator)
        }
    }
    
    func each<K : Hashable, V>(iterator: (K, V) -> Any) -> () {
        if let wrapped = self._wrapped as? [K:V] {
            __.each(wrapped, iterator)
        }
    }
    
    // alias for each
    func forEach<T>(iterator: T -> Any) -> () {
        self.each(iterator)
    }
    
    // alias for each
    func forEach<K : Hashable, V>(iterator: (K, V) -> Any) -> () {
        self.each(iterator)
    }
    
    func map<T, U>(transform: T -> U) -> __.Chain<[U]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain(wrapped.map(transform))
        }
        return nil
    }
    
    
    func map<K : Hashable, V, T>(transform: (K, V) -> T) -> __.Chain<[T]>! {
        if let wrapped = self._wrapped as? [K:V] {
            var result : [T] = []
            var gen = wrapped.generate()
            while let elem = gen.next() {
                result += transform(elem)
            }
            return __.chain( result )
        }
        return nil
    }
    
    func collect<T, U>(transform: T -> U) -> __.Chain<[U]>! {
        return self.map(transform)
    }
    
    func collect<K : Hashable, V, T>(transform: (K, V) -> T) -> __.Chain<[T]>! {
        return self.map(transform)
    }
    
    func reduce<T, U>(initial: U, combine:(U, T) -> U) -> __.Chain<U>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain(wrapped.reduce(initial, combine: combine))
        }
        return nil
    }
    
    func reduce<K : Hashable, V, T>(initial: T, combine:(T, (K, V)) -> T) -> __.Chain<T>! {
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
    func inject<T, U>(initial: U, combine:(U, T) -> U ) -> __.Chain<U>! {
        return self.reduce(initial, combine: combine)
    }
    
    // alias for reduce
    func inject<K : Hashable, V, T>(initial: T, combine:(T, (K, V)) -> T) -> __.Chain<T>! {
        return self.reduce(initial, combine: combine)
    }
    
    // alias for reduce
    func foldl<T, U>(initial: U, combine:(U, T) -> U ) -> __.Chain<U>! {
        return self.reduce(initial, combine: combine)
    }
    
    // alias for reduce
    func foldl<K : Hashable, V, T>(initial: T, combine:(T, (K, V)) -> T) -> __.Chain<T>! {
        return self.reduce(initial, combine: combine)
    }
    
    func reduceRight<T, U>(initial: U, combine:(T, U) -> U) -> __.Chain<U>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.reduceRight(wrapped, initial: initial, combine: combine) )
        }
        return nil
    }
    
    func reduceRight<K : Hashable, V, T>(initial: T, combine:((K, V), T) -> T) -> __.Chain<T>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.reduceRight(wrapped, initial: initial, combine: combine) )
        }
        return nil
    }
    
    // alias for reduceRight
    func foldr<T, U>(initial: U, combine:(T, U) -> U) -> __.Chain<U>! {
        return self.reduceRight(initial, combine: combine)
    }
    
    // alias for reduceRight
    func foldr<K : Hashable, V, T>(initial: T, combine:((K, V), T) -> T) -> __.Chain<T>! {
        return self.reduceRight(initial, combine: combine)
    }
    
    func find<T>(predicate: T -> Bool) -> __.Chain<T?>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.find(wrapped, predicate: predicate) )
        }
        return nil
    }
    
    func find<K : Hashable, V>(predicate: (K,V) -> Bool) -> __.Chain<(K, V)?>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.find(wrapped, predicate: predicate) )
        }
        return nil
    }
    
    // alias for find
    func detect<T>(predicate: T -> Bool) -> __.Chain<T?>! {
        return self.find(predicate)
    }
    
    // alias for find
    func detect<K : Hashable, V>(predicate: (K,V) -> Bool) -> __.Chain<(K, V)?>! {
        return self.find(predicate)
    }
    
    func filter<T>(predicate: T -> Bool) -> __.Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( wrapped.filter(predicate) )
        }
        return nil
    }
    
    func filter<K : Hashable, V>(predicate: (K,V) -> Bool) -> __.Chain<[(K, V)]>! {
        if let wrapped = self._wrapped as? [K:V] {
            var result : [(K, V)] = []
            for (key, value) in wrapped {
                if predicate(key, value) {
                    result += (key, value)
                }
            }
            return __.chain( result )
        }
        return nil
    }
    
    // alias for filter
    func select<T>(predicate: T -> Bool) -> __.Chain<[T]>! {
        return self.filter(predicate)
    }
    
    // alias for filter
    func select<K : Hashable, V>(predicate: (K,V) -> Bool) -> __.Chain<[(K, V)]>! {
        return self.filter(predicate)
    }
    
    func `where`<K,V: Equatable>(array: [[K:V]], _ properties: [K:V]) -> __.Chain<[[K:V]]>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.`where`(array, properties) )
        }
        return nil
    }
    
    func findWhere<K,V: Equatable>(array: [[K:V]], _ properties: [K:V]) -> __.Chain<[K:V]?>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.findWhere(array, properties) )
        }
        return nil
    }
    
    func reject<T>(predicate: T -> Bool) -> __.Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( wrapped.filter({ !predicate($0) }) )
        }
        return nil
    }
    
    func reject<K : Hashable, V>(predicate: (K,V) -> Bool) -> __.Chain<[(K, V)]>! {
        if let wrapped = self._wrapped as? [K:V] {
            return self.filter({ !predicate($0) })
        }
        return nil
    }
    
    func every<L: LogicValue>() -> __.Chain<Bool>! {
        if let wrapped = self._wrapped as? [L] {
            return __.chain( __.every(wrapped) )
        }
        return nil
    }
    
    func every<T>(predicate: T -> Bool ) -> __.Chain<Bool>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.every(wrapped, predicate) )
        }
        return nil
    }
    
    // alias for every
    func all<L: LogicValue>() -> __.Chain<Bool>! {
        return self.every({ (x:LogicValue) -> Bool in x.getLogicValue() })
    }
    
    // alias for every
    func all<T>(predicate: T -> Bool ) -> __.Chain<Bool>! {
        return self.every(predicate)
    }
    
    func some<L: LogicValue>() -> __.Chain<Bool>! {
        if let wrapped = self._wrapped as? [L] {
            return __.chain( __.some(wrapped) )
        }
        return nil
    }
    
    func some<T>(predicate: T -> Bool ) -> __.Chain<Bool>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.some(wrapped, predicate) )
        }
        return nil
    }
    
    // alias for some
    func any<L: LogicValue>() -> __.Chain<Bool>! {
        return self.some({ (x:LogicValue) -> Bool in x.getLogicValue() })
    }
    
    // alias for some
    func any<T>(predicate: T -> Bool ) -> __.Chain<Bool>! {
        return self.some(predicate)
    }
    
    func contains<E : Equatable>(x: E) -> __.Chain<Bool>! {
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
    
    func contains<K : Hashable, V : Equatable>(x: (K, V)) -> __.Chain<Bool>! {
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
    func include<E : Equatable>(x: E) -> __.Chain<Bool>! {
        return self.contains(x)
    }
    
    // alias for contains
    func include<K : Hashable, V : Equatable>(x: (K, V)) -> __.Chain<Bool>! {
        return self.contains(x)
    }
    
    func pluck<K : Hashable, V>(key : K) -> __.Chain<[V]>! {
        if let wrapped = self._wrapped as? [[K:V]] {
            return __.chain( __.pluck(wrapped, key: key) )
        }
        return nil
    }
    
    func max<C : Comparable>() -> __.Chain<C>! {
        if let wrapped = self._wrapped as? [C] {
            return __.chain( maxElement(wrapped) )
        }
        return nil
    }
    
    func min<C : Comparable>() -> __.Chain<C>! {
        if let wrapped = self._wrapped as? [C] {
            return __.chain( minElement(wrapped) )
        }
        return nil
    }
    
    func sortBy<T, U : Comparable>(transform: T -> U) -> __.Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.sortBy(wrapped, transform: transform) )
        }
        return nil
    }
    
    func groupBy<K, V>(transform: V -> K) -> __.Chain<[K:[V]]>! {
        if let wrapped = self._wrapped as? [V] {
            return __.chain( __.groupBy(wrapped, transform) )
        }
        return nil
    }
    
    func indexBy<K, V>(key: K) -> __.Chain<[V:[K:V]]>! {
        if let wrapped = self._wrapped as? [[K:V]] {
            return __.chain( __.indexBy(wrapped, key: key) )
        }
        return nil
    }
    
    func countBy<T, U>(transform: T -> U) -> __.Chain<[U:Int]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.countBy(wrapped, transform:transform) )
        }
        return nil
    }
    
    func shuffle<T>() -> __.Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.shuffle(wrapped) )
        }
        return nil
    }
    
    func sample<T>() -> __.Chain<T>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.sample(wrapped) )
        }
        return nil
    }
    
    func sample<T>(n:Int) -> __.Chain<[T]>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.sample(wrapped, n) )
        }
        return nil
    }
    
    func size<T>() -> __.Chain<Int>! {
        if let wrapped = self._wrapped as? [T] {
            return __.chain( __.size(wrapped) )
        }
        return nil
    }
    
    func size<K : Hashable,V>() -> __.Chain<Int>! {
        if let wrapped = self._wrapped as? [K:V] {
            return __.chain( __.size(wrapped) )
        }
        return nil
    }
}