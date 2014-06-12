//
//  __Collections.swift
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
    * Collection Functions (Arrays or Dictionaries)
    */
    
    class func each<T : Sequence>(seq: T, _ iterator: T.GeneratorType.Element -> Any){
        var gen = seq.generate()
        while let elem = gen.next() {
            iterator(elem)
        }
    }
    
    // alias for each
    class func forEach<T : Sequence>(seq: T, _ iterator: T.GeneratorType.Element -> Any){
        __.each(seq, iterator)
    }
    
    // Swift has map method in Array by default
    // __'s map method is bridge to the default function
    class func map<T, U>(list: T[], transform: T -> U) -> U[] {
        return list.map(transform)
    }
    
    class func map<T : Sequence, U>(seq: T, transform: T.GeneratorType.Element -> U) -> U[] {
        var result = U[]()
        var gen = seq.generate()
        while let elem = gen.next() {
            result += transform(elem)
        }
        return result
    }
    
    // alias for map
    class func collect<T, U>(list: T[], transform: T -> U) -> U[] {
        return list.map(transform)
    }
    
    class func collect<T: Sequence, U>(seq: T, transform: T.GeneratorType.Element -> U) -> U[] {
        return __.map(seq, transform: transform)
    }
    
    // Swift has reduce method in Array by default
    // __'s map method is bridge to the default function
    class func reduce<T, U>(list: T[], initial: U, combine: (U, T) -> U) -> U {
        return list.reduce(initial, combine: combine)
    }
    
    class func reduce<T : Sequence, U>(seq: T, initial: U, combine: (U, T.GeneratorType.Element) -> U) -> U {
        var accum = initial
        var gen = seq.generate()
        while let elem = gen.next() {
            accum = combine(accum, elem)
        }
        return accum
    }

    class func foldl1<T : Sequence>(seq: T, combine: (T.GeneratorType.Element, T.GeneratorType.Element) -> T.GeneratorType.Element) -> T.GeneratorType.Element {
        var accum : T.GeneratorType.Element?
        var gen = seq.generate()
        while let elem = gen.next() {
            accum = accum ? combine(accum!, elem) : elem
        }
        return accum!
    }
    
    // alias for reduce
    class func inject<T, U>(list: T[], initial: U, combine: (U, T) -> U) -> U {
        return list.reduce(initial, combine: combine)
    }
    
    class func inject<T : Sequence, U>(seq: T, initial: U, combine: (U, T.GeneratorType.Element) -> U) -> U {
        return __.reduce(seq, initial: initial, combine: combine);
    }
    
    // alias for reduce
    class func foldl<T, U>(list: T[], initial: U, combine: (U, T) -> U) -> U {
        return list.reduce(initial, combine: combine)
    }
    
    class func foldl<T : Sequence, U>(seq: T, initial: U, combine: (U, T.GeneratorType.Element) -> U) -> U {
        return __.reduce(seq, initial: initial, combine: combine);
    }
    
    class func reduceRight<T : Sequence, U>(seq: T, initial: U, combine: (T.GeneratorType.Element, U) -> U) -> U {
        var array = Array<T.GeneratorType.Element>()
        var gen = seq.generate()
        while let elem = gen.next() {
            array += elem
        }
        return array.reverse().reduce(initial, combine: { combine($1,$0) } )
    }
    
    class func find<T : Sequence>(seq: T, condition: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element? {
        var gen = seq.generate()
        while let elem = gen.next() {
            if condition(elem) {
                return elem
            }
        }
        return nil
    }
    
    // alias for find
    class func detect<T : Sequence>(seq: T, _ filter: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element? {
        return __.find(seq, filter)
    }
    
    
    class func filter<T : Sequence>(seq: T, _ filter: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element[] {
        var result = Array<T.GeneratorType.Element>()
        var gen = seq.generate()
        while let elem = gen.next() {
            if filter(elem) {
                result += elem
            }
        }
        return result
    }
    
    // alias for filter
    class func select<T : Sequence>(seq: T, _ filter: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element[] {
        return __.filter(seq, filter)
    }
 
    class func `where`<K,V: Equatable>(list: Array<Dictionary<K,V>>, _ properties: Dictionary<K,V>) -> Array<Dictionary<K,V>> {
        var result = Array<Dictionary<K,V>>()
        for dict in list {
            if __.hasSubDictionary(dict, subDictionary: properties) {
                result += dict
            }
        }
        return result
    }
    
    class func findWhere<K,V: Equatable>(list: Array<Dictionary<K,V>>, _ properties: Dictionary<K,V>) -> Dictionary<K,V>? {
        for dict in list {
            if __.hasSubDictionary(dict, subDictionary: properties) {
                return dict
            }
        }
        return nil
    }
    
    class func reject<T : Sequence>(seq: T, _ filter: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element[] {
        return __.filter(seq, { !filter($0) })
    }
    
    class func every<L: LogicValue>(list: L[]) -> Bool {
        return __.find(list, { !$0 }) ? false : true
    }
    
    class func every<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool ) -> Bool {
        return __.find(seq, { !predicate($0) }) ? false : true
    }
    
    // alias for every
    class func all<L: LogicValue>(list: L[]) -> Bool {
        return __.every(list)
    }
    
    class func all<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.every(seq, predicate: predicate)
    }
    
    class func some<L: LogicValue>(list: L[]) -> Bool {
        return __.find(list, { $0.getLogicValue() }) ? true : false
    }
    
    class func some<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.find(seq, predicate ) ? true : false
    }
    
    // alias for any
    class func any<L: LogicValue>(list: L[]) -> Bool {
        return __.some(list)
    }
    
    class func any<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.some(seq, predicate: predicate)
    }
    
    // Simple linear search
    class func contains<T : Sequence where T.GeneratorType.Element : Equatable>(seq: T, value: T.GeneratorType.Element) -> Bool {
        return __.find(seq, {value==$0}) ? true : false
    }
    
    // alias for contains
    class func include<T : Sequence where T.GeneratorType.Element : Equatable>(seq: T, value: T.GeneratorType.Element) -> Bool {
        return __.contains(seq, value: value);
    }
    
    class func pluck<K, V>(list: Array<Dictionary<K, V>>, key: K) -> V[] {
        var result = V[]()
        for item in list {
            if let value = item[key] {
                result += value
            }
        }
        return result
    }
    
    class func max<T : Sequence where T.GeneratorType.Element : Comparable>(seq: T) -> T.GeneratorType.Element {
        return __.foldl1(seq, combine: { $1 > $0 ? $1 : $0 })
    }
    
    class func max<C: Comparable>(list: C...) -> C {
        return __.max(list)
    }
    
    class func min<T : Sequence where T.GeneratorType.Element : Comparable>(seq: T) -> T.GeneratorType.Element {
        return __.foldl1(seq, combine: { $0 < $1 ? $0 : $1 })
    }

    class func min<C: Comparable>(list: C...) -> C {
        return __.min(list)
    }
    
    // quick sort
    class func sortBy<T : Sequence, C: Comparable>(seq: T, transform: T.GeneratorType.Element -> C) -> T.GeneratorType.Element[] {
        
        var gen = seq.generate()
        
        if let first = gen.next() {
            
            var smaller = Array<T.GeneratorType.Element>()
            var bigger = Array<T.GeneratorType.Element>()
            
            while let elem = gen.next() {
                if transform(first) < transform(elem) {
                    bigger += elem
                } else {
                    smaller += elem
                }
            }
            
            var result = sortBy(smaller, transform: transform)
            result += first
            result += sortBy(bigger, transform: transform)
            
            return result
        } else {
            return []
        }
    }
    
    class func groupBy<K, V>(list: V[], _ iterator: V -> K) -> Dictionary<K, V[]> {
        var result = Dictionary<K, V[]>()
        
        for item in list {
            let key = iterator(item)
            if let array = result[key] {
                result[key] = array + [item]
            } else {
                result[key] = [item]
            }
        }
        
        return result
    }
    
    class func indexBy<K, V>(list: Array< Dictionary<K, V> >, _ key: K) -> Dictionary<V, Dictionary<K,V> > {
        var result = Dictionary<V, Dictionary<K,V> >()
        for item in list {
            result[item[key]!] = item
        }
        return result
    }
    
    class func countBy<T, U>(list: T[], _ iterator: T -> U) -> Dictionary<U, Int> {
        var result = Dictionary<U, Int>()
        for item in list {
            if let count = result[iterator(item)] {
                result[iterator(item)] = count + 1
            } else {
                result[iterator(item)] = 1
            }
        }
        return result
    }
    
    class func shuffle<T>(list: T[]) -> T[] {
        let length = list.count
        var random = Int[]()
        while random.count < length {
            let index = __.random(length-1)
            if !__.contains(random, value: index) {
                random += index
            }
        }
        return __.map(random) { list[$0] }
    }
    
    class func sample<T>(list: T[]) -> T {
        let index = __.random(list.count-1)
        return list[index]
    }
    
    class func sample<T>(list: T[], _ n:Int) -> T[] {
        var result = T[]()
        let random = __.shuffle(Array(0..list.count))
        for i in 0..n {
            result += list[random[i]]
        }
        return result
    }
    
    class func size<T>(list: T[]) -> Int {
        return list.count
    }
    
    class func size<K, V>(dict: Dictionary<K, V>) -> Int {
        return Array(dict.keys).count
    }
    
}
