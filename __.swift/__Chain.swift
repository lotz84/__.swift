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

extension __ {

    /*
     * This is only chain concept here.
     * Actually, unknown error is occured before compiling.
     */

    class func chain<T>(wrapped: T) -> Chain<T> {
        return Chain(wrapped)
    }
    
    
    struct Chain<T> {
        
        var _wrapped: T
        
        init(_ wrapped: T) {
            self._wrapped = wrapped
        }
        
        func value() -> T {
            return self._wrapped
        }
        
        /**
        * Collection Functions (Arrays or Dictionaries)
        */
        
        func each<U>(iterator: U -> Any) -> () {
            if let wrapped = self._wrapped as? U[] {
                __.each(wrapped, iterator)
            }
        }
        
        func each<K : Hashable, V>(iterator: (K, V) -> Any) -> () {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                __.each(wrapped, iterator)
            }
        }
        
        // alias for each
        func forEach<U>(iterator: U -> Any) -> () {
            self.each(iterator)
        }
        
        // alias for each
        func forEach<K : Hashable, V>(iterator: (K, V) -> Any) -> () {
            self.each(iterator)
        }
        
        // The native map function for Sequence doesn't work for now. This is only temporary.
        static func map<K : Hashable, V, T>(dict:Dictionary<K,V>, transform: (K, V) -> T) -> T[] {
            var result = T[]()
            var gen = dict.generate()
            while let elem = gen.next() {
                result += transform(elem)
            }
            return result
        }
        
        func map<U, V>(transform: U -> V) -> Chain<Array<V>>? {
            if let wrapped = self._wrapped as? U[] {
                // If you miss the prefix "__.", it doesn't work for now.
                return __.chain(wrapped.map(transform))
            }
            return nil
        }
        
        func map<K : Hashable, V, U>(transform: (K, V) -> U) -> Chain<Array<U>>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return __.chain(Chain.map(wrapped, transform))
            }
            return nil
        }
        
        func collect<U, V>(transform: U -> V) -> Chain<Array<V>>? {
            return self.map(transform)
        }
        
        func collect<K : Hashable, V, U>(transform: (K, V) -> U) -> Chain<Array<U>>? {
            return self.map(transform)
        }
        
        func reduce<U, V>(initial: V, combine:(V, U) -> V ) -> Chain<V>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain(wrapped.reduce(initial, combine: combine))
            }
            return nil
        }
        
        
        // The native reduce function for Sequence doesn't work for now. This is only temporary.
        static func reduce<K : Hashable, V, U>(dict: Dictionary<K, V>, initial: U, combine:(U, (K, V)) -> U) -> U {
            var accum = initial
            var gen = dict.generate()
            while let elem = gen.next() {
                accum = combine(accum, elem)
            }
            return accum
        }
        
        func reduce<K : Hashable, V, U>(initial: U, combine:(U, (K, V)) -> U) -> Chain<U>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return __.chain( Chain.reduce(wrapped, initial: initial, combine: combine) )
            }
            return nil
        }
        
        // alias for reduce
        func inject<U, V>(initial: V, combine:(V, U) -> V ) -> Chain<V>? {
            if let wrapped = self._wrapped as? U[] {
                return self.reduce(initial, combine: combine)
            }
            return nil
        }
        
        // alias for reduce
        func inject<K : Hashable, V, U>(initial: U, combine:(U, (K, V)) -> U) -> Chain<U>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return self.reduce(initial, combine: combine)
            }
            return nil
        }
        
        // alias for reduce
        func foldl<U, V>(initial: V, combine:(V, U) -> V ) -> Chain<V>? {
            if let wrapped = self._wrapped as? U[] {
                return self.reduce(initial, combine: combine)
            }
            return nil
        }
        
        // alias for reduce
        func foldl<K : Hashable, V, U>(initial: U, combine:(U, (K, V)) -> U) -> Chain<U>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return self.reduce(initial, combine: combine)
            }
            return nil
        }
        
        func reduceRight<U, V>(initial: V, combine:(U, V) -> V ) -> Chain<V>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain( __.reduceRight(wrapped, initial: initial, combine: combine) )
            }
            return nil
        }
        
        func reduceRight<K : Hashable, V, U>(initial: U, combine:((K, V), U) -> U) -> Chain<U>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return __.chain( __.reduceRight(wrapped, initial: initial, combine: combine) )
            }
            return nil
        }
        
        // alias for reduceRight
        func foldr<U, V>(initial: V, combine:(U, V) -> V ) -> Chain<V>? {
            if let wrapped = self._wrapped as? U[] {
                return self.reduceRight(initial, combine: combine)
            }
            return nil
        }
        
        // alias for reduceRight
        func foldr<K : Hashable, V, U>(initial: U, combine:((K, V), U) -> U) -> Chain<U>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return self.reduceRight(initial, combine: combine)
            }
            return nil
        }
        
        func find<U>(predicate: U -> Bool) -> Chain<U?>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain( __.find(wrapped, predicate: predicate) )
            }
            return nil
        }
        
        func find<K : Hashable, V>(predicate: (K,V) -> Bool) -> Chain<(K, V)?>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return __.chain( __.find(wrapped, predicate: predicate) )
            }
            return nil
        }
        
        // alias for find
        func detect<U>(predicate: U -> Bool) -> Chain<U?>? {
            if let wrapped = self._wrapped as? U[] {
                return self.find(predicate)
            }
            return nil
        }
        
        // alias for find
        func detect<K : Hashable, V>(predicate: (K,V) -> Bool) -> Chain<(K, V)?>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return self.find(predicate)
            }
            return nil
        }
        
        // The native filter function for Sequence doesn't work for now. This is only temporary.
        static func filter<K : Hashable, V>(dict: Dictionary<K, V>, includeElement: (K, V) -> Bool) -> Array<(K, V)> {
            var result = Array<(K, V)>()
            for (key, value) in dict {
                if includeElement(key, value) {
                    result += (key, value)
                }
            }
            return result
        }
        
        func filter<U>(predicate: U -> Bool) -> Chain<Array<U>>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain( wrapped.filter(predicate) )
            }
            return nil
        }
        
        func filter<K : Hashable, V>(predicate: (K,V) -> Bool) -> Chain<Array<(K, V)>>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return __.chain( Chain.filter(wrapped, predicate) )
            }
            return nil
        }
        
        // alias for filter
        func select<U>(predicate: U -> Bool) -> Chain<Array<U>>? {
            if let wrapped = self._wrapped as? U[] {
                return self.filter(predicate)
            }
            return nil
        }
        
        // alias for filter
        func select<K : Hashable, V>(predicate: (K,V) -> Bool) -> Chain<Array<(K, V)>>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return self.filter(predicate)
            }
            return nil
        }
        
        func `where`<K,V: Equatable>(array: Array<Dictionary<K,V>>, _ properties: Dictionary<K,V>) -> Chain<Array<Dictionary<K,V>>>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return __.chain( __.`where`(array, properties) )
            }
            return nil
        }
        
        func findWhere<K,V: Equatable>(array: Array<Dictionary<K,V>>, _ properties: Dictionary<K,V>) -> Chain<Dictionary<K,V>?>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return __.chain( __.findWhere(array, properties) )
            }
            return nil
        }
        
        func reject<U>(predicate: U -> Bool) -> Chain<Array<U>>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain( wrapped.filter({ !predicate($0) }) )
            }
            return nil
        }
        
        func reject<K : Hashable, V>(predicate: (K,V) -> Bool) -> Chain<Array<(K, V)>>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return __.chain( Chain.filter(wrapped, { !predicate($0) }) )
            }
            return nil
        }
        
        func every<L: LogicValue>() -> Chain<Bool>? {
            if let wrapped = self._wrapped as? L[] {
                return __.chain( __.every(wrapped) )
            }
            return nil
        }
        
        func every<U>(predicate: U -> Bool ) -> Chain<Bool>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain( __.every(wrapped, predicate) )
            }
            return nil
        }
        
        // alias for every
        func all<L: LogicValue>() -> Chain<Bool>? {
            if let wrapped = self._wrapped as? L[] {
                return self.every({ (x:LogicValue) -> Bool in x.getLogicValue() })
            }
            return nil
        }
        
        // alias for every
        func all<U>(predicate: U -> Bool ) -> Chain<Bool>? {
            if let wrapped = self._wrapped as? U[] {
                return self.every(predicate)
            }
            return nil
        }
        
        func some<L: LogicValue>() -> Chain<Bool>? {
            if let wrapped = self._wrapped as? L[] {
                return __.chain( __.some(wrapped) )
            }
            return nil
        }
        
        func some<U>(predicate: U -> Bool ) -> Chain<Bool>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain( __.some(wrapped, predicate) )
            }
            return nil
        }
        
        // alias for some
        func any<L: LogicValue>() -> Chain<Bool>? {
            if let wrapped = self._wrapped as? L[] {
                return self.some({ (x:LogicValue) -> Bool in x.getLogicValue() })
            }
            return nil
        }
        
        // alias for some
        func any<U>(predicate: U -> Bool ) -> Chain<Bool>? {
            if let wrapped = self._wrapped as? U[] {
                return self.some(predicate)
            }
            return nil
        }
        
        static func contains<U : Sequence where U.GeneratorType.Element : Equatable>(seq: U, x: U.GeneratorType.Element) -> Bool {
            var gen = seq.generate()
            while let elem = gen.next() {
                if elem == x {
                    return true
                }
            }
            return false
        }
        
        static func contains<K: Equatable, V: Equatable>(dict: Dictionary<K, V>, x: (K, V)) -> Bool {
            for (key, value) in dict {
                if key==x.0 && value==x.1 {
                    return true
                }
            }
            return false
        }
        
        func contains<U : Equatable>(x: U) -> Chain<Bool>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain( Chain.contains(wrapped, x: x) )
            }
            return nil
        }
        
        func contains<K : Hashable, V : Equatable>(x: (K, V)) -> Chain<Bool>? {
            if let wrapped = self._wrapped as? Dictionary<K,V> {
                return __.chain( Chain.contains(wrapped, x: x) )
            }
            return nil
        }
        
        // alias for contains
        func include<U : Equatable>(x: U) -> Chain<Bool>? {
            if let wrapped = self._wrapped as? U[] {
                return self.contains(x)
            }
            return nil
        }
        
        // alias for contains
        func include<K : Hashable, V : Equatable>(x: (K, V)) -> Chain<Bool>? {
            if let wrapped = self._wrapped as? Dictionary<K,V> {
                return self.contains(x)
            }
            return nil
        }
        
        func pluck<K : Hashable, V>(key : K) -> Chain<Array<V>>? {
            if let wrapped = self._wrapped as? Array<Dictionary<K, V>> {
                return __.chain( __.pluck(wrapped, key: key) )
            }
            return nil
        }
        
        func max<U : Comparable>() -> Chain<U>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain( maxElement(wrapped) )
            }
            return nil
        }
        
        func min<U : Comparable>() -> Chain<U>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain( minElement(wrapped) )
            }
            return nil
        }
        
        func sortBy<U, V : Comparable>(transform: U -> V) -> Chain<Array<U>>? {
            if let wrapped = self._wrapped as? U[] {
                return __.chain( __.sortBy(wrapped, transform: transform) )
            }
            return nil
        }
        
        func groupBy<K, V>(transform: V -> K) -> Chain<Dictionary<K, Array<V>>>? {
            if let wrapped = self._wrapped as? V[] {
                return __.chain( __.groupBy(wrapped, transform) )
            }
            return nil
        }
        
        func indexBy<K, V>(key: K) -> Chain<Dictionary<V, Dictionary<K,V>>>? {
            if let wrapped = self._wrapped as? Array<Dictionary<K, V>> {
                return __.chain( __.indexBy(wrapped, key: key) )
            }
            return nil
        }
        
        func countBy<T, U>(transform: T -> U) -> Chain<Dictionary<U, Int>>? {
            if let wrapped = self._wrapped as? T[] {
                return __.chain( __.countBy(wrapped, transform:transform) )
            }
            return nil
        }
        
        func shuffle<T>() -> Chain<T[]>? {
            if let wrapped = self._wrapped as? T[] {
                return __.chain( __.shuffle(wrapped) )
            }
            return nil
        }
        
        func sample<T>() -> Chain<T>? {
            if let wrapped = self._wrapped as? T[] {
                return __.chain( __.sample(wrapped) )
            }
            return nil
        }
        
        func sample<T>(n:Int) -> Chain<T[]>? {
            if let wrapped = self._wrapped as? T[] {
                return __.chain( __.sample(wrapped, n) )
            }
            return nil
        }

        func size<T>() -> Chain<Int>? {
            if let wrapped = self._wrapped as? T[] {
                return __.chain( __.size(wrapped) )
            }
            return nil
        }
        
        
        func size<K : Hashable,V>() -> Chain<Int>? {
            if let wrapped = self._wrapped as? Dictionary<K, V> {
                return __.chain( __.size(wrapped) )
            }
            return nil
        }
    }
}